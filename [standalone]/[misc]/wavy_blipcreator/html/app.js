const RESOURCE = (typeof GetParentResourceName === "function")
  ? GetParentResourceName()
  : "wavy_blipcreator";

const app = document.getElementById("app");
const toast = document.getElementById("toast");

const closeBtn = document.querySelector(".close-btn");
const copyBtn = document.getElementById("copyBtn");

const coordCopyBtn = document.getElementById("coordCopyBtn");
const coordX = document.getElementById("coordX");
const coordY = document.getElementById("coordY");
const coordZ = document.getElementById("coordZ");

const blipList = document.getElementById("blipList");
const blipName = document.getElementById("blipName");
const spriteInput = document.getElementById("spriteInput");
const spriteGrid = document.getElementById("spriteGrid");
const radiusInput = document.getElementById("radiusInput");

const btnClear = document.getElementById("btnClear");
const btnSave = document.getElementById("btnSave");

const refInput = document.querySelector(".export-input");

let state = {
  isOpen: false,
  blips: [],
  editingId: null, 
  scale: 1.0,
  colorHex: "#FFFFFF",
  sprite: 1,
};

let toastTimer = null;

function showToast(msg) {
  toast.textContent = msg;
  toast.classList.add("show");
  if (toastTimer) clearTimeout(toastTimer);
  toastTimer = setTimeout(() => toast.classList.remove("show"), 1200);
}

function postNui(name, data = {}) {
  return fetch(`https://${RESOURCE}/${name}`, {
    method: "POST",
    headers: { "Content-Type": "application/json; charset=UTF-8" },
    body: JSON.stringify(data),
  }).then((r) => r.json().catch(() => ({})));
}

async function copyText(text) {
  try {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      await navigator.clipboard.writeText(text);
      return true;
    }
  } catch (_) {}

  try {
    const ta = document.createElement("textarea");
    ta.value = text;
    ta.setAttribute("readonly", "");
    ta.style.position = "absolute";
    ta.style.left = "-9999px";
    ta.style.top = "-9999px";
    document.body.appendChild(ta);
    ta.select();
    ta.setSelectionRange(0, ta.value.length);
    const ok = document.execCommand("copy");
    document.body.removeChild(ta);
    return !!ok;
  } catch (_) {
    return false;
  }
}

function setCopyButtonSuccess() {
  copyBtn.classList.add("copied");
  const svg = copyBtn.querySelector("svg");
  if (svg) svg.innerHTML = `<path d="M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"></path>`;
  setTimeout(() => {
    copyBtn.classList.remove("copied");
    if (svg) svg.innerHTML = `<path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 16H8V7h11v14z"/>`;
  }, 850);
}

function escapeHtml(str) {
  return String(str)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function openUI(blips = []) {
  state.isOpen = true;
  state.blips = blips;
  app.classList.add("show");
  renderBlipList();
  clearEditor(false);
}

function closeUI() {
  state.isOpen = false;
  app.classList.remove("show");
  state.editingId = null;
}

function renderBlipList() {
  const list = Array.isArray(state.blips) ? state.blips : [];

  const draftActive = state.editingId == null ? "active" : "";
  let html = `
    <div class="blip-list-item ${draftActive}" data-id="__draft__">
      <div class="blip-number">NEW</div>
      <h4>Unnamed</h4>
      <p>Empty draft</p>
    </div>
  `;

  if (list.length > 0) {
    html += list.map((b, i) => {
      const active = String(b.id) === String(state.editingId) ? "active" : "";
      const name = (b.name && String(b.name)) || "Unnamed";
      const sprite = b.sprite != null ? b.sprite : "";
      const scale = b.scale != null ? b.scale : "";
      return `
        <div class="blip-list-item ${active}" data-id="${escapeHtml(b.id)}">
          <div class="blip-number">#${i + 1}</div>
          <h4>${escapeHtml(name)}</h4>
          <p>Sprite ${escapeHtml(sprite)} · ${escapeHtml(scale)}x</p>
          <button class="blip-delete" data-del="${escapeHtml(b.id)}" title="Delete">×</button>
        </div>
      `;
    }).join("");
  }

  blipList.innerHTML = html;

  blipList.querySelectorAll(".blip-list-item").forEach((el) => {
    el.addEventListener("click", (e) => {
      const del = e.target?.getAttribute?.("data-del");
      if (del) return;

      const id = el.getAttribute("data-id");
      if (id === "__draft__") {
        clearEditor(false);
        renderBlipList();
        return;
      }

      const b = state.blips.find((x) => String(x.id) === String(id));
      if (!b) return;

      state.editingId = b.id;
      loadEditorFromBlip(b);
      renderBlipList();
    });
  });

  blipList.querySelectorAll("[data-del]").forEach((btn) => {
    btn.addEventListener("click", async (e) => {
      e.preventDefault();
      e.stopPropagation();
      const id = btn.getAttribute("data-del");
      await postNui("deleteBlip", { id });
      showToast("Deleted");
    });
  });
}

function loadEditorFromBlip(b) {
  blipName.value = b.name ?? "";
  coordX.value = b.coords?.x ?? "";
  coordY.value = b.coords?.y ?? "";
  coordZ.value = b.coords?.z ?? "";
  spriteInput.value = b.sprite ?? "";
  radiusInput.value = b.radius ?? "";

  state.scale = Number(b.scale ?? 1.0);
  state.colorHex = (b.color ?? "#FFFFFF").toUpperCase();
  state.sprite = Number(b.sprite ?? 1);

  document.querySelectorAll(".scale-btn").forEach((btn) => {
    btn.classList.toggle("active", Number(btn.dataset.scale) === Number(state.scale));
  });

  document.querySelectorAll(".color-option").forEach((el) => {
    el.classList.toggle("active", el.dataset.hex === state.colorHex);
  });

  setActiveSprite(state.sprite);
}

function clearEditor(showMsg = true) {
  state.editingId = null;
  blipName.value = "";
  coordX.value = "";
  coordY.value = "";
  coordZ.value = "";
  spriteInput.value = "1";
  radiusInput.value = "0";

  state.scale = 1.0;
  state.colorHex = "#FFFFFF";
  state.sprite = 1;

  document.querySelectorAll(".scale-btn").forEach((btn) => {
    btn.classList.toggle("active", btn.dataset.scale === "1.0");
  });
  document.querySelectorAll(".color-option").forEach((el) => {
    el.classList.toggle("active", el.dataset.hex === "#FFFFFF");
  });

  setActiveSprite(1);

  if (showMsg) showToast("Cleared");
}

const COLORS = [
  "#FFFFFF", "#000000",
  "#FF0000", "#00FF00", "#0000FF",
  "#FFFF00", "#00FFFF", "#FF00FF",
  "#FFA500", "#800080", "#008080",
  "#ADFF2F", "#FFD700"
];

const colorSelector = document.getElementById("colorSelector");
colorSelector.innerHTML = COLORS.map((hex) => (
  `<div class="color-option ${hex === "#FFFFFF" ? "active" : ""}" data-hex="${hex}" style="background:${hex}"></div>`
)).join("");

colorSelector.querySelectorAll(".color-option").forEach((el) => {
  el.addEventListener("click", () => {
    state.colorHex = el.dataset.hex;
    document.querySelectorAll(".color-option").forEach((x) => x.classList.toggle("active", x === el));
  });
});

document.querySelectorAll(".scale-btn").forEach((btn) => {
  if (!btn.dataset.scale) btn.dataset.scale = btn.textContent.trim();
  btn.addEventListener("click", () => {
    state.scale = Number(btn.dataset.scale);
    document.querySelectorAll(".scale-btn").forEach((x) => x.classList.toggle("active", x === btn));
  });
});

const SPRITE_IDS = [
  0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,
  27,28,36,38,40,41,42,43,47,50,51,52,56,58,59,60,61,
  66,67,68,71,72,73,75,84,85,90,93,94,100,102,103,109,110,119,121,122,135,136,
  140,147,150,162,198,207,225,226,251,255,266,273,279,303,304,305,308,310,311,
  313,353,354,361,374,390,402,421,422
];

function buildSpriteGrid() {
  if (!spriteGrid) return;

  spriteGrid.innerHTML = SPRITE_IDS.map((id) => {
    return `
      <div class="sprite-item" data-sprite="${id}">
        <img src="img/${id}.png" alt="${id}" draggable="false" />
        <div class="sprite-number">${id}</div>
      </div>
    `;
  }).join("");

  spriteGrid.querySelectorAll(".sprite-item").forEach((el) => {
    el.addEventListener("click", () => {
      const id = Number(el.dataset.sprite);
      state.sprite = id;
      spriteInput.value = String(id);
      setActiveSprite(id);
    });
  });

  setActiveSprite(state.sprite);
}

function setActiveSprite(id) {
  if (!spriteGrid) return;
  spriteGrid.querySelectorAll(".sprite-item").forEach((el) => {
    el.classList.toggle("active", Number(el.dataset.sprite) === Number(id));
  });
}

spriteInput.addEventListener("input", () => {
  const id = Number(spriteInput.value || 0);
  if (!Number.isFinite(id)) return;
  state.sprite = id;
  setActiveSprite(id);
});

buildSpriteGrid();

closeBtn.addEventListener("click", async () => {
  await postNui("close", {});
});

btnClear.addEventListener("click", () => {
  clearEditor(true);
  renderBlipList();
});

btnSave.addEventListener("click", async () => {
  const isNew = state.editingId == null;

  const payload = {
    id: state.editingId,
    name: blipName.value || "Unnamed",
    scale: Number(state.scale || 1.0),
    color: state.colorHex,
    sprite: Number(spriteInput.value || state.sprite || 1),
    radius: Number(radiusInput.value || 0),
    coords: {
      x: Number(coordX.value || 0),
      y: Number(coordY.value || 0),
      z: Number(coordZ.value || 0),
    }
  };

  await postNui("saveBlip", payload);
  showToast(isNew ? "Blip saved" : "Blip updated");

  if (isNew) {
    clearEditor(false);
    state.editingId = null;
    renderBlipList();
  } else {
    renderBlipList();
  }
});

copyBtn.addEventListener("click", async () => {
  const text = refInput?.value || "https://docs.fivem.net/docs/game-references/blips/";
  const ok = await copyText(text);
  if (!ok) return showToast("Failed to copy");
  setCopyButtonSuccess();
  showToast("Copied!");
});

coordCopyBtn.addEventListener("click", async () => {
  const res = await postNui("getCoords", {});
  if (!res || res.x == null) return showToast("Failed to get coords");

  const x = Number(res.x).toFixed(2);
  const y = Number(res.y).toFixed(2);
  const z = Number(res.z).toFixed(2);

  coordX.value = x;
  coordY.value = y;
  coordZ.value = z;

  const ok = await copyText(`${x}, ${y}, ${z}`);
  showToast(ok ? "Coordinates copied" : "Coords set (copy failed)");
});

window.addEventListener("message", (event) => {
  const data = event.data;
  if (!data || !data.type) return;

  if (data.type === "open") openUI(data.blips || []);
  if (data.type === "close") closeUI();

  if (data.type === "setBlips") {
    state.blips = data.blips || [];
    if (state.editingId != null) {
      const stillExists = state.blips.some((b) => String(b.id) === String(state.editingId));
      if (!stillExists) clearEditor(false);
    }
    renderBlipList();
  }

  if (data.type === "toast") {
    showToast(data.msg || "Done");
  }
});

closeUI();
