let enabled = false;
let pttDown = false;

let stream = null;
let audioCtx = null;
let sourceNode = null;
let processor = null;

let socket = null;
let keepAliveTimer = null;
let reconnectTimer = null;

let ttsSessionId = 0;

let DG_KEY = null;
let STT_MODEL = "nova-2";
let LANG = "en-US";
let TTS_VOICE = "aura-2-thalia-en";

const $root = document.getElementById("alexa-root");
const $chip = document.getElementById("alexa-chip");
const $sub = document.getElementById("alexa-sub");
const $hint = document.getElementById("alexa-hint");
const $orb = document.getElementById("alexa-orb");
const $state = document.getElementById("alexa-state");
const $live = document.getElementById("alexa-live");
const $assistantName = document.getElementById("assistant-name");

let pttKeyLabel = "Z";
let powerKeyLabel = "ALT";

let uiLock = null;

let queuedTtsText = null;


let ttsAudio = new Audio();
ttsAudio.preload = "auto";

let silenceTimer = null;
let lastFinalAt = 0;

function clearSilenceTimer() {
  if (silenceTimer) clearTimeout(silenceTimer);
  silenceTimer = null;
}

function stopTTS() {

  ttsSessionId++;

  try {
    ttsAudio.onended = null;
    ttsAudio.onerror = null;
    ttsAudio.onpause = null;
  } catch {}

  try { ttsAudio.pause(); ttsAudio.currentTime = 0; } catch {}


  if (uiLock === "speaking") uiLock = null;
}

function showUI(on) {
  if (!$root) return;
  $root.style.display = on ? "block" : "none";
  if ($chip) {
    $chip.textContent = on ? "ON" : "OFF";
    $chip.classList.toggle("on", !!on);
  }
}

function setHintKey() {
  if ($hint) {
    $hint.innerHTML = `Press <b>${pttKeyLabel}</b> to speak <span class="aai-sep">•</span> Press <b>${powerKeyLabel}</b> to stop assistant`;
  }
}

function setOrbState(mode, line) {

  if (uiLock === "speaking" && mode !== "speaking") return;
  if (uiLock === "listening" && (mode === "idle" || mode === "thinking")) return;

  if ($orb) {
    $orb.classList.remove("is-idle", "is-listening", "is-thinking", "is-speaking");
    $orb.classList.add(
      mode === "listening" ? "is-listening" :
      mode === "thinking" ? "is-thinking" :
      mode === "speaking" ? "is-speaking" : "is-idle"
    );
  }

  if ($state) $state.textContent = mode.charAt(0).toUpperCase() + mode.slice(1);
  if ($live && typeof line === "string") $live.textContent = line || "—";
}

function setSub(text) {
  if ($sub) $sub.textContent = text || "";
}

function postFinalToLua(text) {
  fetch(`https://${GetParentResourceName()}/alexa_text`, {
    method: "POST",
    headers: { "Content-Type": "application/json; charset=UTF-8" },
    body: JSON.stringify({ text })
  }).catch(() => {});
}

async function getConfigFromLua() {
  const res = await fetch(`https://${GetParentResourceName()}/alexa_getConfig`, {
    method: "POST",
    headers: { "Content-Type": "application/json; charset=UTF-8" },
    body: JSON.stringify({})
  });
  const j = await res.json();
  if (!j || !j.ok) throw new Error("Failed to get config from Lua");
  DG_KEY = j.key;
  STT_MODEL = j.sttModel || STT_MODEL;
  LANG = j.language || LANG;
  TTS_VOICE = j.ttsVoiceModel || TTS_VOICE;
}

function buildSTTUrl() {
  return (
    "wss://api.deepgram.com/v1/listen" +
    `?model=${encodeURIComponent(STT_MODEL)}` +
    `&language=${encodeURIComponent(LANG)}` +
    "&encoding=linear16&sample_rate=16000&channels=1" +
    "&interim_results=true&endpointing=150&vad_events=true"
  );
}

function buildTTSUrl() {
  return `https://api.deepgram.com/v1/speak?model=${encodeURIComponent(TTS_VOICE)}`;
}

async function speakTTS(text) {
  if (!text || !DG_KEY) return;

  stopTTS();

  const mySession = ++ttsSessionId;

  uiLock = "speaking";
  setOrbState("speaking", text);
  setSub(text);

  try {
    const res = await fetch(buildTTSUrl(), {
      method: "POST",
      headers: {
        "Authorization": `Token ${DG_KEY}`,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ text })
    });

    if (!res.ok) {
      if (mySession === ttsSessionId) {
        uiLock = null;
        setOrbState("idle", "—");
        setSub(`TTS error: ${res.status}`);
      }
      return;
    }

    const blob = await res.blob();
    const url = URL.createObjectURL(blob);


    ttsAudio.onended = () => {
      if (mySession !== ttsSessionId) return;
      try { URL.revokeObjectURL(url); } catch {}
      uiLock = null;
      if (!pttDown) {
        setOrbState("idle", "—");
        setSub(`Press ${pttKeyLabel} to speak`);
      }
    };

    ttsAudio.onerror = () => {
      if (mySession !== ttsSessionId) return;
      try { URL.revokeObjectURL(url); } catch {}
      uiLock = null;
      setOrbState("idle", "—");
      setSub("TTS failed");
    };

    ttsAudio.src = url;
    await ttsAudio.play();

    if (mySession !== ttsSessionId) {
      try { ttsAudio.pause(); } catch {}
      try { URL.revokeObjectURL(url); } catch {}
      return;
    }

  } catch {
    if (mySession === ttsSessionId) {
      uiLock = null;
      setOrbState("idle", "—");
      setSub("TTS failed");
    }
  }
}
const TARGET_SR = 16000;
const FRAME_SAMPLES = 320;
let pcmQueue = [];
let frameTimer = null;
let inSR = 48000;

function downsampleTo16k(float32, sampleRate) {
  if (sampleRate === TARGET_SR) return float32;
  const ratio = sampleRate / TARGET_SR;
  const outLen = Math.round(float32.length / ratio);
  const out = new Float32Array(outLen);
  for (let i = 0; i < outLen; i++) {
    const idx = i * ratio;
    const i0 = Math.floor(idx);
    const i1 = Math.min(i0 + 1, float32.length - 1);
    const frac = idx - i0;
    out[i] = float32[i0] * (1 - frac) + float32[i1] * frac;
  }
  return out;
}

function floatToInt16(float32) {
  const out = new Int16Array(float32.length);
  for (let i = 0; i < float32.length; i++) {
    let s = Math.max(-1, Math.min(1, float32[i]));
    out[i] = s < 0 ? (s * 0x8000) : (s * 0x7fff);
  }
  return out;
}

function stopTimers() {
  if (frameTimer) clearInterval(frameTimer);
  frameTimer = null;
  if (keepAliveTimer) clearInterval(keepAliveTimer);
  keepAliveTimer = null;
  if (reconnectTimer) clearTimeout(reconnectTimer);
  reconnectTimer = null;
}

function connectSTT() {
  if (!DG_KEY) return;

  stopTimers();
  try { socket?.close(1000); } catch {}
  socket = null;

  socket = new WebSocket(buildSTTUrl(), ["token", DG_KEY]);
  socket.binaryType = "arraybuffer";

  socket.onopen = () => {
    setOrbState("idle", "—");
    setSub(`Press ${pttKeyLabel} to speak`);
    setHintKey();

    keepAliveTimer = setInterval(() => {
      if (socket && socket.readyState === WebSocket.OPEN) {
        try { socket.send(JSON.stringify({ type: "KeepAlive" })); } catch {}
      }
    }, 10000);

    frameTimer = setInterval(() => {
      if (!pttDown) return;
      if (!socket || socket.readyState !== WebSocket.OPEN) return;

      while (pcmQueue.length >= FRAME_SAMPLES) {
        const frame = new Int16Array(FRAME_SAMPLES);
        for (let i = 0; i < FRAME_SAMPLES; i++) frame[i] = pcmQueue[i];
        pcmQueue = pcmQueue.slice(FRAME_SAMPLES);
        try { socket.send(frame.buffer); } catch {}
      }
    }, 20);
  };

  socket.onclose = () => {
    if (!enabled) return;
    setOrbState("thinking", "Reconnecting…");
    setSub("STT closed, reconnecting…");
    reconnectTimer = setTimeout(connectSTT, 800);
  };

  socket.onmessage = (msg) => {
    try {
      const data = JSON.parse(msg.data);
      const transcript = (data?.channel?.alternatives?.[0]?.transcript || "").trim();
      const isFinal = data?.is_final === true;
      const speechFinal = data?.speech_final === true;

      if (transcript && !isFinal && !speechFinal) {
        if (pttDown) setOrbState("listening", transcript);
        return;
      }

      if ((isFinal || speechFinal) && transcript) {
		  lastFinalAt = Date.now();
		  clearSilenceTimer();		  
        uiLock = "thinking";
        setOrbState("thinking", transcript);
        setSub(transcript);

        postFinalToLua(transcript);

        setTimeout(() => {
          if (!enabled) return;
          if (pttDown) return;
          if (uiLock === "speaking") return;
          if (uiLock === "thinking") {
            uiLock = null;
            setOrbState("idle", "—");
            setSub(`Press ${pttKeyLabel} to speak`);
          }
        }, 2200);
      }
    } catch {}
  };

  socket.onerror = () => {};
}

async function initAudio() {
  if (audioCtx) return;

  stream = await navigator.mediaDevices.getUserMedia({
    audio: { echoCancellation: true, noiseSuppression: true, autoGainControl: true }
  });

  audioCtx = new (window.AudioContext || window.webkitAudioContext)();
  inSR = audioCtx.sampleRate;

  sourceNode = audioCtx.createMediaStreamSource(stream);
  processor = audioCtx.createScriptProcessor(2048, 1, 1);

  processor.onaudioprocess = (ev) => {
    if (!pttDown) return;
    const input = ev.inputBuffer.getChannelData(0);
    const ds = downsampleTo16k(input, inSR);
    const pcm16 = floatToInt16(ds);
    for (let i = 0; i < pcm16.length; i++) pcmQueue.push(pcm16[i]);
  };

  sourceNode.connect(processor);
  processor.connect(audioCtx.destination);
}

async function teardownAudio() {
  pcmQueue = [];

  if (processor) {
    processor.onaudioprocess = null;
    try { processor.disconnect(); } catch {}
    processor = null;
  }
  if (sourceNode) {
    try { sourceNode.disconnect(); } catch {}
    sourceNode = null;
  }
  if (audioCtx) {
    try { await audioCtx.close(); } catch {}
    audioCtx = null;
  }
  if (stream) {
    stream.getTracks().forEach(t => t.stop());
    stream = null;
  }
}

async function startModule() {
  if (enabled) return;
  enabled = true;

  showUI(true);
  setHintKey();
  setOrbState("idle", "—");
  setSub("Loading…");

  try {
    await getConfigFromLua();
  } catch {
    enabled = false;
    setOrbState("idle", "—");
    setSub("Config error");
    return;
  }

  if (!DG_KEY || DG_KEY.length < 10) {
    enabled = false;
    setOrbState("idle", "—");
    setSub("Missing Deepgram key");
    return;
  }

  try {
    await initAudio();
  } catch {
    enabled = false;
    setOrbState("idle", "—");
    setSub("Mic denied/error");
    return;
  }

  connectSTT();
}

async function stopModule() {
  enabled = false;
  pttDown = false;

  stopTTS();
  stopTimers();

  try { socket?.close(1000); } catch {}
  socket = null;

  await teardownAudio();

  uiLock = null;
  setOrbState("idle", "—");
  setSub("");
  showUI(false);
}

function setPTT(down) {
  if (!enabled) return;
  pttDown = !!down;

  if (pttDown) {
	  clearSilenceTimer();
    stopTTS(); 
    uiLock = "listening";
    setOrbState("listening", "Listening…");
    setSub("Listening…");
} else {

  uiLock = "thinking";
  setOrbState("thinking", "Thinking…");
  setSub("Thinking…");

  try {
    if (socket && socket.readyState === WebSocket.OPEN) {
      socket.send(JSON.stringify({ type: "Finalize" }));
    }
  } catch {}

  clearSilenceTimer();
  const startedAt = Date.now();
  silenceTimer = setTimeout(() => {
    if (!enabled) return;
    if (pttDown) return;   
    if (uiLock === "speaking") return; 
    if (lastFinalAt < startedAt) {
      uiLock = null;
      setOrbState("idle", "—");
      setSub(`Press ${pttKeyLabel} to speak`);
    }
  }, 1100);
}
}

window.addEventListener("message", (event) => {
  const d = event.data || {};

  if (d.type === "ANGEL_ON") {
    if (d.keyLabel) pttKeyLabel = String(d.keyLabel);
    if (d.keyLabelClose) powerKeyLabel = String(d.keyLabelClose);
    if (d.assistantName && $assistantName) $assistantName.textContent = String(d.assistantName).toUpperCase();

    startModule();
  }

  if (d.type === "ANGEL_OFF") stopModule();
  if (d.type === "ANGEL_PTT") setPTT(!!d.down);
  if (d.type === "ANGEL_TTS") speakTTS(d.text || "");
});

showUI(false);