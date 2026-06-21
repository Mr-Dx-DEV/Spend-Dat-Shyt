// ============================================================
//   NASTY DEVELOPMENTS — Loading Screen v2  •  script.js
// ============================================================

// ── SVG icon library ─────────────────────────────────────────
var SocialIcons = {
  discord: '<svg viewBox="0 0 24 24" fill="currentColor"><path d="M20.317 4.37a19.791 19.791 0 0 0-4.885-1.515.074.074 0 0 0-.079.037c-.21.375-.444.864-.608 1.25a18.27 18.27 0 0 0-5.487 0 12.64 12.64 0 0 0-.617-1.25.077.077 0 0 0-.079-.037A19.736 19.736 0 0 0 3.677 4.37a.07.07 0 0 0-.032.027C.533 9.046-.32 13.58.099 18.057c.002.022.015.04.032.05a19.9 19.9 0 0 0 5.993 3.03.078.078 0 0 0 .084-.028c.462-.63.874-1.295 1.226-1.994a.076.076 0 0 0-.041-.106 13.107 13.107 0 0 1-1.872-.892.077.077 0 0 1-.008-.128 10.2 10.2 0 0 0 .372-.292.074.074 0 0 1 .077-.01c3.928 1.793 8.18 1.793 12.062 0a.074.074 0 0 1 .078.01c.12.098.246.198.373.292a.077.077 0 0 1-.006.127 12.299 12.299 0 0 1-1.873.892.077.077 0 0 0-.041.107c.36.698.772 1.362 1.225 1.993a.076.076 0 0 0 .084.028 19.839 19.839 0 0 0 6.002-3.03.077.077 0 0 0 .032-.054c.5-5.177-.838-9.674-3.549-13.66a.061.061 0 0 0-.031-.03zM8.02 15.33c-1.183 0-2.157-1.085-2.157-2.419 0-1.333.956-2.419 2.157-2.419 1.21 0 2.176 1.096 2.157 2.42 0 1.333-.956 2.418-2.157 2.418zm7.975 0c-1.183 0-2.157-1.085-2.157-2.419 0-1.333.955-2.419 2.157-2.419 1.21 0 2.176 1.096 2.157 2.42 0 1.333-.946 2.418-2.157 2.418z"/></svg>',
  youtube:  '<svg viewBox="0 0 24 24" fill="currentColor"><path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/></svg>',
  tiktok:   '<svg viewBox="0 0 24 24" fill="currentColor"><path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-2.88 2.5 2.89 2.89 0 0 1-2.89-2.89 2.89 2.89 0 0 1 2.89-2.89c.28 0 .54.04.79.1V9.01a6.27 6.27 0 0 0-.79-.05 6.34 6.34 0 0 0-6.34 6.34 6.34 6.34 0 0 0 6.34 6.34 6.34 6.34 0 0 0 6.33-6.34V8.69a8.18 8.18 0 0 0 4.78 1.52V6.75a4.85 4.85 0 0 1-1.01-.06z"/></svg>',
  x:        '<svg viewBox="0 0 24 24" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-4.714-6.231-5.401 6.231H2.744l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>',
  instagram:'<svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98C8.333 23.986 8.741 24 12 24c3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 1 0 0 12.324 6.162 6.162 0 0 0 0-12.324zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm6.406-11.845a1.44 1.44 0 1 0 0 2.881 1.44 1.44 0 0 0 0-2.881z"/></svg>',
  twitch:   '<svg viewBox="0 0 24 24" fill="currentColor"><path d="M11.571 4.714h1.715v5.143H11.57zm4.715 0H18v5.143h-1.714zM6 0L1.714 4.286v15.428h5.143V24l4.286-4.286h3.428L22.286 12V0zm14.571 11.143l-3.428 3.428h-3.429l-3 3v-3H6.857V1.714h13.714z"/></svg>',
};

// ── Persistence helpers ──────────────────────────────────────
var STORAGE_KEY = 'nastyls_v2';

function saveSettings(obj) {
  try {
    var current = loadSettings();
    var merged  = {};
    for (var k in current) merged[k] = current[k];
    for (var k in obj)     merged[k] = obj[k];
    localStorage.setItem(STORAGE_KEY, JSON.stringify(merged));
  } catch (e) {}
}

function loadSettings() {
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}');
  } catch (e) { return {}; }
}

// ── State ────────────────────────────────────────────────────
var audio        = document.getElementById('audio-player');
var tracks       = [];
var currentTrack = 0;
var isPlaying    = false;
var slideIndex   = 0;
var slideTimer   = null;
var tipIndex     = 0;
var tipTimer     = null;
var tracklistOpen = false;

// ── Boot ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', function () {
  applyAccentColor();
  applyConfig();
  buildSocials();
  buildRules();
  buildSlideshow();
  buildTrackList();
  startTips();
  startParticles();
  setupPlayerEvents();

  if (Config.ShuffleTracks) shuffleTracks();

  // Restore saved settings (volume, last track)
  var saved = loadSettings();
  var savedVol = (saved.volume !== undefined) ? saved.volume : (Config.DefaultVolume || 60);
  audio.volume = savedVol / 100;
  document.getElementById('volume-slider').value = savedVol;
  updateVolIcon(savedVol);

  var startTrack = (saved.trackIndex !== undefined && saved.trackIndex < tracks.length)
    ? saved.trackIndex : 0;

  if (Config.AutoPlay && tracks.length > 0) {
    loadTrack(startTrack, true);
  }

  // Close tracklist when clicking outside
  document.addEventListener('click', function (e) {
    var popup  = document.getElementById('tracklist-popup');
    var toggle = document.getElementById('tracklist-toggle');
    if (tracklistOpen && !popup.contains(e.target) && e.target !== toggle && !toggle.contains(e.target)) {
      closeTracklist();
    }
  });
});

// ── Accent colour injection ──────────────────────────────────
function applyAccentColor() {
  var hex = (Config.AccentColor || '#7c3aed').replace('#', '');
  var r = parseInt(hex.slice(0,2), 16);
  var g = parseInt(hex.slice(2,4), 16);
  var b = parseInt(hex.slice(4,6), 16);

  var root = document.documentElement;
  root.style.setProperty('--accent',        Config.AccentColor);
  root.style.setProperty('--accent-mid',    lighten(r,g,b, 0.15));
  root.style.setProperty('--accent-bright', lighten(r,g,b, 0.28));
  root.style.setProperty('--accent-glow',   'rgba('+r+','+g+','+b+',0.45)');
  root.style.setProperty('--accent-dim',    'rgba('+r+','+g+','+b+',0.12)');
  root.style.setProperty('--accent-border', 'rgba('+r+','+g+','+b+',0.28)');
  root.style.setProperty('--accent-border-bright', 'rgba('+r+','+g+','+b+',0.55)');
  root.style.setProperty('--border',        'rgba('+r+','+g+','+b+',0.22)');
  root.style.setProperty('--border-hi',     'rgba('+r+','+g+','+b+',0.50)');
}

function lighten(r,g,b,amount) {
  r = Math.min(255, Math.round(r + (255 - r) * amount));
  g = Math.min(255, Math.round(g + (255 - g) * amount));
  b = Math.min(255, Math.round(b + (255 - b) * amount));
  return 'rgb('+r+','+g+','+b+')';
}

// ── Apply Config ─────────────────────────────────────────────
function applyConfig() {
  // Badge
  document.getElementById('badge-season').textContent  = Config.Season  || 'SEASON 1';
  document.getElementById('badge-version').textContent = Config.Version || 'v1.0';

  // Player count
  document.getElementById('max-players').textContent = Config.MaxPlayers || 200;

  // Tagline
  document.getElementById('tagline').textContent = Config.Tagline || '';

  // Server name under loading bar
  document.getElementById('loading-server-name').textContent = (Config.ServerName || '').toUpperCase();

  // Volume slider default
  document.getElementById('volume-slider').value = Config.DefaultVolume || 60;
  audio.volume = (Config.DefaultVolume || 60) / 100;

  // Tracks
  tracks = Config.Tracks || [];
}

// ── Social Links ─────────────────────────────────────────────
function buildSocials() {
  var wrap = document.getElementById('social-links');
  (Config.Socials || []).forEach(function (s) {
    var a = document.createElement('a');
    a.className = 'social-btn';
    a.title     = s.label || s.icon;
    a.href      = '#';
    a.setAttribute('data-url', s.url || '#');
    a.innerHTML = SocialIcons[s.icon] || SocialIcons.discord;
    a.addEventListener('click', function (e) {
      e.preventDefault();
      openSocial(s.url);
    });
    wrap.appendChild(a);
  });
}

function openSocial(url) {
  // In FiveM NUI use SendNUIMessage / NUI callback to open browser
  // In browser preview this just logs
  console.log('[NastyLS] Open:', url);
}

// ── Rules Modal ──────────────────────────────────────────────
function buildRules() {
  var body = document.getElementById('rules-body');
  (Config.Rules || []).forEach(function (text, i) {
    var item = document.createElement('div');
    item.className = 'rule-item';
    item.innerHTML =
      '<span class="rule-num">' + String(i + 1).padStart(2, '0') + '</span>' +
      '<span class="rule-text">' + escapeHtml(text) + '</span>';
    body.appendChild(item);
  });
}

function toggleRules() {
  var modal = document.getElementById('rules-modal');
  modal.classList.toggle('open');
}

function overlayClose(e) {
  if (e.target === document.getElementById('rules-modal')) toggleRules();
}

// ── Background Slideshow ─────────────────────────────────────
function buildSlideshow() {
  var wrap   = document.getElementById('bg-wrap');
  var images = Config.BackgroundImages || [];

  if (Config.BackgroundType === 'video') {
    var vid = document.createElement('video');
    vid.autoplay = true;
    vid.loop     = true;
    vid.muted    = true;
    vid.setAttribute('autoplay', '');
    vid.setAttribute('loop', '');
    vid.setAttribute('muted', '');
    vid.setAttribute('playsinline', '');
    vid.className = 'bg-video';
    vid.style.cssText = 'position:absolute;inset:0;width:100%;height:100%;object-fit:cover;';
    var src = document.createElement('source');
    src.src  = Config.BackgroundVideo || 'images/background.mp4';
    src.type = 'video/mp4';
    vid.appendChild(src);
    wrap.appendChild(vid);
    vid.load();
    vid.play().catch(function () {
      // Autoplay blocked by browser — will play on first user interaction
      document.addEventListener('click', function onFirstClick() {
        vid.play().catch(function () {});
        document.removeEventListener('click', onFirstClick);
      }, { once: true });
    });
    return;
  }

  if (!images.length) return;

  images.forEach(function (img, i) {
    var div = document.createElement('div');
    div.className = 'bg-slide' + (i === 0 ? ' active' : '');
    div.style.backgroundImage = 'url(' + img + ')';
    wrap.appendChild(div);
  });

  if (images.length > 1) {
    var interval = Config.SlideshowInterval || 7000;
    slideTimer = setInterval(advanceSlide, interval);
  }
}

function advanceSlide() {
  var slides = document.querySelectorAll('.bg-slide');
  if (!slides.length) return;
  slides[slideIndex].classList.remove('active');
  slideIndex = (slideIndex + 1) % slides.length;
  slides[slideIndex].classList.add('active');
}

// ── Tips Rotator ─────────────────────────────────────────────
function startTips() {
  var tips = Config.Tips || [];
  if (!tips.length) return;

  var el = document.getElementById('tip-text');
  el.textContent = tips[0];

  var interval = Config.TipInterval || 5000;
  tipTimer = setInterval(function () {
    tipIndex = (tipIndex + 1) % tips.length;
    el.classList.add('out');
    setTimeout(function () {
      el.textContent = tips[tipIndex];
      el.classList.remove('out');
    }, 360);
  }, interval);
}

// ── Track List ───────────────────────────────────────────────
function buildTrackList() {
  var list = document.getElementById('track-list');
  if (!tracks.length) {
    list.innerHTML = '<div class="no-tracks">Drop .mp3 files into <code>ui/music/</code><br>and add them to <code>config.js</code></div>';
    return;
  }
  tracks.forEach(function (t, i) {
    var div = document.createElement('div');
    div.className = 'track-item' + (i === 0 ? ' active' : '');
    div.dataset.index = i;
    div.innerHTML =
      '<span class="t-num">' + (i + 1) + '</span>' +
      '<div class="t-info">' +
        '<span class="t-name">'   + escapeHtml(t.title)  + '</span>' +
        '<span class="t-artist">' + escapeHtml(t.artist) + '</span>' +
      '</div>';
    div.addEventListener('click', function () { loadTrack(i, true); });
    list.appendChild(div);
  });
}

function refreshTrackList() {
  var items = document.querySelectorAll('.track-item');
  items.forEach(function (el) {
    el.classList.toggle('active', parseInt(el.dataset.index) === currentTrack);
  });
}

function shuffleTracks() {
  for (var i = tracks.length - 1; i > 0; i--) {
    var j = Math.floor(Math.random() * (i + 1));
    var tmp = tracks[i]; tracks[i] = tracks[j]; tracks[j] = tmp;
  }
}

// ── Music Player ─────────────────────────────────────────────
function loadTrack(index, play) {
  if (!tracks.length) return;
  currentTrack = index;
  var t = tracks[index];
  audio.src = t.file;

  document.getElementById('track-name').textContent   = t.title;
  document.getElementById('track-artist').textContent = t.artist;
  document.getElementById('progress-fill').style.width = '0%';
  document.getElementById('current-time').textContent  = '0:00';
  document.getElementById('total-time').textContent    = '0:00';

  refreshTrackList();
  saveSettings({ trackIndex: index });

  if (play) {
    audio.play().then(setPlaying).catch(function () {});
  }
}

function setPlaying() {
  isPlaying = true;
  document.getElementById('play-icon').style.display  = 'none';
  document.getElementById('pause-icon').style.display = 'block';
  document.getElementById('eq').classList.add('active');
}

function setPaused() {
  isPlaying = false;
  document.getElementById('play-icon').style.display  = 'block';
  document.getElementById('pause-icon').style.display = 'none';
  document.getElementById('eq').classList.remove('active');
}

function setupPlayerEvents() {
  // Play / Pause
  document.getElementById('play-pause-btn').addEventListener('click', function () {
    if (!tracks.length) return;
    if (isPlaying) {
      audio.pause(); setPaused();
    } else {
      if (!audio.src || audio.src === window.location.href) loadTrack(0, false);
      audio.play().then(setPlaying).catch(function () {});
    }
  });

  // Next / Prev
  document.getElementById('next-btn').addEventListener('click', function () {
    loadTrack((currentTrack + 1) % tracks.length, isPlaying);
  });
  document.getElementById('prev-btn').addEventListener('click', function () {
    loadTrack((currentTrack - 1 + tracks.length) % tracks.length, isPlaying);
  });

  // Auto-advance
  audio.addEventListener('ended', function () {
    loadTrack((currentTrack + 1) % tracks.length, true);
  });

  // Progress updates
  audio.addEventListener('timeupdate', updateSeekBar);
  audio.addEventListener('loadedmetadata', function () {
    document.getElementById('total-time').textContent = fmtTime(audio.duration);
  });

  // Seek on click
  var seekBar = document.getElementById('seek-bar');
  seekBar.addEventListener('click', function (e) {
    var rect  = seekBar.getBoundingClientRect();
    var ratio = Math.max(0, Math.min(1, (e.clientX - rect.left) / rect.width));
    if (audio.duration) audio.currentTime = ratio * audio.duration;
  });

  // Volume — save on change
  var volSlider = document.getElementById('volume-slider');
  volSlider.addEventListener('input', function () {
    var v = parseInt(this.value);
    audio.volume = v / 100;
    updateVolIcon(v);
    saveSettings({ volume: v });
  });
  updateVolIcon(volSlider.value);

  // Tracklist toggle
  document.getElementById('tracklist-toggle').addEventListener('click', function (e) {
    e.stopPropagation();
    tracklistOpen ? closeTracklist() : openTracklist();
  });
}

function openTracklist() {
  tracklistOpen = true;
  document.getElementById('tracklist-popup').classList.add('open');
}
function closeTracklist() {
  tracklistOpen = false;
  document.getElementById('tracklist-popup').classList.remove('open');
}

function updateSeekBar() {
  if (!audio.duration) return;
  var pct = (audio.currentTime / audio.duration) * 100;
  document.getElementById('progress-fill').style.width = pct + '%';
  document.getElementById('current-time').textContent  = fmtTime(audio.currentTime);
}

function updateVolIcon(val) {
  var v = parseInt(val);
  var icon = document.getElementById('vol-icon');
  if (v === 0) {
    icon.innerHTML = '<path d="M16.5 12c0-1.77-1.02-3.29-2.5-4.03v2.21l2.45 2.45c.03-.2.05-.41.05-.63zm2.5 0c0 .94-.2 1.82-.54 2.64l1.51 1.51C20.63 14.91 21 13.5 21 12c0-4.28-2.99-7.86-7-8.77v2.06c2.89.86 5 3.54 5 6.71zM4.27 3L3 4.27 7.73 9H3v6h4l5 5v-6.73l4.25 4.25c-.67.52-1.42.93-2.25 1.18v2.06c1.38-.31 2.63-.95 3.69-1.81L19.73 21 21 19.73l-9-9L4.27 3zM12 4L9.91 6.09 12 8.18V4z"/>';
  } else if (v < 50) {
    icon.innerHTML = '<path d="M18.5 12c0-1.77-1.02-3.29-2.5-4.03v8.05c1.48-.73 2.5-2.25 2.5-4.02zM5 9v6h4l5 5V4L9 9H5z"/>';
  } else {
    icon.innerHTML = '<path d="M3 9v6h4l5 5V4L7 9H3zm13.5 3c0-1.77-1.02-3.29-2.5-4.03v8.05c1.48-.73 2.5-2.25 2.5-4.02zM14 3.23v2.06c2.89.86 5 3.54 5 6.71s-2.11 5.85-5 6.71v2.06c4.01-.91 7-4.49 7-8.77s-2.99-7.86-7-8.77z"/>';
  }
}

function fmtTime(s) {
  if (isNaN(s) || !isFinite(s)) return '0:00';
  var m = Math.floor(s / 60);
  var sec = Math.floor(s % 60);
  return m + ':' + (sec < 10 ? '0' : '') + sec;
}

// ── Loading Progress ─────────────────────────────────────────
function setLoadingProgress(pct) {
  pct = Math.max(0, Math.min(100, pct));
  document.getElementById('loading-bar-fill').style.width = pct + '%';
  document.getElementById('loading-percent').textContent  = pct + '%';

  var label;
  if      (pct <  10) label = 'CONNECTING TO SERVER…';
  else if (pct <  30) label = 'AUTHENTICATING…';
  else if (pct <  50) label = 'LOADING RESOURCES…';
  else if (pct <  65) label = 'SYNCING SCRIPTS…';
  else if (pct <  80) label = 'LOADING MAP DATA…';
  else if (pct <  95) label = 'ALMOST THERE…';
  else if (pct < 100) label = 'FINALIZING…';
  else                label = 'WELCOME TO ' + (Config.ServerName || 'THE SERVER').toUpperCase() + '!';
  document.getElementById('loading-text').textContent = label;
}

// ── Constellation Particles ──────────────────────────────────
function startParticles() {
  var canvas = document.getElementById('particles');
  var ctx    = canvas.getContext('2d');
  var W, H;
  var pts    = [];
  var LINK   = 130;
  var COUNT  = 55;

  function resize() {
    W = canvas.width  = window.innerWidth;
    H = canvas.height = window.innerHeight;
  }
  resize();
  window.addEventListener('resize', resize);

  for (var i = 0; i < COUNT; i++) {
    pts.push({
      x:     Math.random() * window.innerWidth,
      y:     Math.random() * window.innerHeight,
      vx:    (Math.random() - 0.5) * 0.28,
      vy:    (Math.random() - 0.5) * 0.28,
      r:     Math.random() * 1.4 + 0.4,
      alpha: Math.random() * 0.35 + 0.08,
    });
  }

  // Parse accent to rgb for particle colour
  var accent = getComputedStyle(document.documentElement).getPropertyValue('--accent').trim();
  var m = accent.match(/\d+/g) || [124,58,237];
  var pr = m[0]||124, pg = m[1]||58, pb = m[2]||237;

  function draw() {
    ctx.clearRect(0, 0, W, H);

    for (var i = 0; i < pts.length; i++) {
      for (var j = i + 1; j < pts.length; j++) {
        var dx   = pts[i].x - pts[j].x;
        var dy   = pts[i].y - pts[j].y;
        var dist = Math.sqrt(dx * dx + dy * dy);
        if (dist < LINK) {
          ctx.beginPath();
          ctx.strokeStyle = 'rgba(' + pr + ',' + pg + ',' + pb + ',' + ((1 - dist / LINK) * 0.14) + ')';
          ctx.lineWidth   = 0.6;
          ctx.moveTo(pts[i].x, pts[i].y);
          ctx.lineTo(pts[j].x, pts[j].y);
          ctx.stroke();
        }
      }
    }

    pts.forEach(function (p) {
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
      ctx.fillStyle = 'rgba(' + pr + ',' + pg + ',' + pb + ',' + p.alpha + ')';
      ctx.fill();
      p.x += p.vx;
      p.y += p.vy;
      if (p.x < 0 || p.x > W) p.vx *= -1;
      if (p.y < 0 || p.y > H) p.vy *= -1;
    });

    requestAnimationFrame(draw);
  }
  draw();
}

// ── Utility ──────────────────────────────────────────────────
function escapeHtml(str) {
  var d = document.createElement('div');
  d.appendChild(document.createTextNode(str));
  return d.innerHTML;
}

// ══════════════════════════════════════════════════════════════
//  FiveM NUI Integration
// ══════════════════════════════════════════════════════════════

// Message bus (player count, custom events)
window.addEventListener('message', function (e) {
  var data = e.data || {};

  switch (data.type) {
    case 'playerCount':
      document.getElementById('online-count').textContent = data.count || 0;
      break;
    case 'loadProgress':
      setLoadingProgress(Math.round((data.value || 0) * 100));
      break;
  }
});

// Native FiveM loading progress event
window.addEventListener('loadProgress', function (e) {
  setLoadingProgress(Math.round((e.detail || 0) * 100));
});

// ── Browser preview fallback ─────────────────────────────────
// Removed in production automatically — FiveM will fire real events.
if (typeof window.SetNuiFocus === 'undefined') {
  (function simulateLoad() {
    var pct = 0;
    var iv  = setInterval(function () {
      pct += Math.random() * 2.8 + 0.4;
      if (pct >= 100) { pct = 100; clearInterval(iv); }
      setLoadingProgress(Math.round(pct));
    }, 180);
  })();
}
