'use strict';

const DEFAULT_THEME_ORDER = ['pink', 'dark', 'green', 'purple', 'teal'];
const THEME_LABELS = {
    pink: 'Pink Mode',
    dark: 'Dark Mode',
    green: 'Green Mode',
    purple: 'Purple Mode',
    teal: 'Teal Mode',
};

const State = {
    open: false,
    standby: false,
    currentPage: 'home',
    pendingGotoPage: null,
    playerData: {},
    currentPartner: null,
    dnaTarget: null,
    pharmacyItems: [],
    pharmacyPayment: 'cash',
    partnerPickerMode: 'relationship',
    pendingUnreg: null,
    pendingConfirm: null,
    toastTimer: null,
    clockTimer: null,
    relativeTimer: null,
    theme: 'green',
    themeOrder: DEFAULT_THEME_ORDER.slice(),
    brocode: { allowed: null, loaded: false, posts: [] },
    coffee: { allowed: null, loaded: false, posts: [] },
    animations: {
        loaded: false,
        filter: 'all',
        debug: false,
        finishMode: 'finish',
        list: [],
    },
    sound: {
        debounceMs: 90,
        lastClickAt: 0,
    },
};

window.State = State;
window.THEME_LABELS = THEME_LABELS;

const PAGE_ALIASES = {
    home: 'home',
    animations: 'animations',
    protection: 'protection',
    pregnancy: 'pregnancy',
    tracker: 'pregnancy',
    std: 'std',
    pharmacy: 'pharmacy',
    dna: 'dna',
    childsupport: 'childsupport',
    babies: 'babyprofiles',
    babyprofiles: 'babyprofiles',
    coffee: 'coffee',
    brocode: 'brocode',
};

function inNuiRuntime() {
    return typeof GetParentResourceName === 'function' || typeof window.GetParentResourceName === 'function';
}

function getResourceName() {
    if (typeof GetParentResourceName === 'function') return GetParentResourceName();
    if (typeof window.GetParentResourceName === 'function') return window.GetParentResourceName();
    return 'grims_lovemenu';
}

window.getResourceName = getResourceName;

function normalizeAssetPath(path) {
    return String(path || '').replace(/^\/+/, '');
}

function localAssetPath(path) {
    const clean = normalizeAssetPath(path);
    if (clean.startsWith('html/')) return clean.slice(5);
    return `../${clean}`;
}

function resourceAsset(path) {
    const clean = normalizeAssetPath(path);
    if (inNuiRuntime()) return `https://${getResourceName()}/${clean}`;
    return localAssetPath(clean);
}

window.resourceAsset = resourceAsset;

function setFallbackState(element) {
    const target = element && element.closest('.brand-mark, .screen-wake__logo, .hero-panel__logo, .app-card__media, .shop-card__media, .anim-card__media, .header-media, .screen-watermark');
    if (target) target.classList.add(target.classList.contains('brand-mark') || target.classList.contains('screen-wake__logo') ? 'is-fallback' : 'has-fallback');
}

function handleAssetError(element) {
    setFallbackState(element);
}

window.handleAssetError = handleAssetError;
window.handleLogoError = handleAssetError;

function mountStaticAssets() {
    const logoSrc = resourceAsset('html/assets/grim_logo.png');
    ['brandLogo', 'wakeLogo', 'watermarkLogo'].forEach((id) => {
        const image = document.getElementById(id);
        if (!image) return;
        image.src = logoSrc;
        image.onerror = () => handleAssetError(image);
    });
}

function aliasPage(page) {
    return PAGE_ALIASES[String(page || 'home').toLowerCase()] || 'home';
}

window.aliasPage = aliasPage;

async function nuiFetch(endpoint, payload = {}) {
    try {
        const response = await fetch(`https://${getResourceName()}/${endpoint}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload),
        });
        const text = await response.text();
        if (!text) return null;
        try {
            return JSON.parse(text);
        } catch (_) {
            return text;
        }
    } catch (_) {
        return null;
    }
}

window.nuiFetch = nuiFetch;

function esc(value) {
    return String(value ?? '')
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
}

window.esc = esc;

function toDate(value) {
    if (!value) return null;
    if (value instanceof Date) return Number.isNaN(value.getTime()) ? null : value;
    if (typeof value === 'number') {
        const date = new Date(value * 1000);
        return Number.isNaN(date.getTime()) ? null : date;
    }
    if (typeof value === 'object') {
        // FiveM MySQL datetime table: { year, month, day, hour, minute, second }
        if (value.year !== undefined) {
            const d = new Date(
                Number(value.year),
                Number(value.month || 1) - 1,
                Number(value.day || 1),
                Number(value.hour || 0),
                Number(value.minute || 0),
                Number(value.second || 0)
            );
            return Number.isNaN(d.getTime()) ? null : d;
        }
        return null;
    }
    const str = String(value).trim();
    // Try direct MySQL datetime format: "YYYY-MM-DD HH:MM:SS"
    const mysqlMatch = str.match(/^(\d{4})-(\d{2})-(\d{2})[T ](\d{2}):(\d{2}):(\d{2})/);
    if (mysqlMatch) {
        const d = new Date(
            Number(mysqlMatch[1]),
            Number(mysqlMatch[2]) - 1,
            Number(mysqlMatch[3]),
            Number(mysqlMatch[4]),
            Number(mysqlMatch[5]),
            Number(mysqlMatch[6])
        );
        return Number.isNaN(d.getTime()) ? null : d;
    }
    // Fallback: standard ISO parse
    const date = new Date(str);
    return Number.isNaN(date.getTime()) ? null : date;
}

window.toDate = toDate;

function formatDateTime(value) {
    const date = toDate(value);
    if (!date) return 'Unknown';
    return date.toLocaleString([], {
        month: 'short',
        day: 'numeric',
        year: 'numeric',
        hour: 'numeric',
        minute: '2-digit',
    });
}

window.formatDateTime = formatDateTime;

function formatShortDate(value) {
    const date = toDate(value);
    if (!date) return 'Unknown';
    return date.toLocaleDateString([], {
        month: 'short',
        day: 'numeric',
        year: 'numeric',
    });
}

window.formatShortDate = formatShortDate;

function formatCurrency(amount) {
    return `$${Number(amount || 0).toLocaleString()}`;
}

window.formatCurrency = formatCurrency;

function timeUntil(value, precise = false) {
    const date = toDate(value);
    if (!date) return 'Inactive';
    const deltaMs = date.getTime() - Date.now();
    if (deltaMs <= 0) return 'Ready now';
    const totalSeconds = Math.ceil(deltaMs / 1000);
    const days = Math.floor(totalSeconds / 86400);
    const hours = Math.floor((totalSeconds % 86400) / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;
    if (precise) {
        if (days > 0) return `${days}d ${hours}h ${minutes}m ${seconds}s`;
        if (hours > 0) return `${hours}h ${minutes}m ${seconds}s`;
        if (minutes > 0) return `${minutes}m ${seconds}s`;
        return `${seconds}s`;
    }
    if (days > 0) return `${days}d ${hours}h`;
    if (hours > 0) return `${hours}h ${minutes}m`;
    return `${minutes}m`;
}

window.timeUntil = timeUntil;

function timeSince(value) {
    const date = toDate(value);
    if (!date) return 'Unknown';
    const deltaMs = Math.max(0, Date.now() - date.getTime());
    const minutes = Math.floor(deltaMs / 60000);
    const days = Math.floor(minutes / 1440);
    const hours = Math.floor((minutes % 1440) / 60);
    if (days > 0) return `${days}d ago`;
    if (hours > 0) return `${hours}h ago`;
    if (minutes > 0) return `${minutes}m ago`;
    return 'Just now';
}

window.timeSince = timeSince;

function preloadSounds() {
    ['click', 'open', 'success', 'error'].forEach((name) => {
        const audio = document.getElementById(`sfx-${name}`);
        if (audio && typeof audio.load === 'function') {
            audio.load();
        }
    });
}

function playSound(name, debounceClick) {
    const audio = document.getElementById(`sfx-${name}`);
    if (!audio) return;

    if (debounceClick === true) {
        const now = Date.now();
        if (now - State.sound.lastClickAt < (State.sound.debounceMs || 90)) {
            return;
        }
        State.sound.lastClickAt = now;
    }

    try {
        audio.currentTime = 0;
        audio.volume = name === 'open' ? 0.42 : 0.5;
        audio.play().catch(() => {});
    } catch (_) {}
}

window.playSound = playSound;

function bindGlobalClickSound() {
    document.addEventListener('click', (event) => {
        if (!State.open || State.standby) return;
        const trigger = event.target.closest('button, summary, .picker-item');
        if (!trigger) return;
        const mode = trigger.dataset.sound || 'click';
        if (mode === 'none' || mode === 'open') return;
        playSound('click', true);
    });
}

function startClock() {
    const update = () => {
        const node = document.getElementById('statusTime');
        if (node) {
            node.textContent = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        }
    };

    update();
    if (State.clockTimer) clearInterval(State.clockTimer);
    State.clockTimer = window.setInterval(update, 15000);
}

function stopClock() {
    if (State.clockTimer) clearInterval(State.clockTimer);
    State.clockTimer = null;
}

function updateRelativeTimers() {
    document.querySelectorAll('[data-time-until]').forEach((node) => {
        node.textContent = timeUntil(node.getAttribute('data-time-until'), node.getAttribute('data-time-precision') === 'true');
    });

    document.querySelectorAll('[data-time-since]').forEach((node) => {
        node.textContent = timeSince(node.getAttribute('data-time-since'));
    });
}

function startRelativeTimer() {
    updateRelativeTimers();
    if (State.relativeTimer) clearInterval(State.relativeTimer);
    State.relativeTimer = window.setInterval(() => {
        if (!State.open) return;
        updateRelativeTimers();
        renderShellState();
    }, 1000);
}

function stopRelativeTimer() {
    if (State.relativeTimer) clearInterval(State.relativeTimer);
    State.relativeTimer = null;
}

function getStoredTheme() {
    try {
        return window.localStorage.getItem('grim_lovemenu.theme');
    } catch (_) {
        return null;
    }
}

function persistTheme(theme) {
    try {
        window.localStorage.setItem('grim_lovemenu.theme', theme);
    } catch (_) {}
    nuiFetch('saveTheme', { theme }).catch(() => {});
}

function setTheme(theme, persist) {
    const order = Array.isArray(State.themeOrder) && State.themeOrder.length ? State.themeOrder : DEFAULT_THEME_ORDER;
    const resolved = order.includes(theme) ? theme : order[0];
    State.theme = resolved;
    const overlay = document.getElementById('overlay');
    if (overlay) overlay.dataset.theme = resolved;
    const label = document.getElementById('themeToggleLabel');
    if (label) label.textContent = THEME_LABELS[resolved] || `${resolved.charAt(0).toUpperCase()}${resolved.slice(1)} Mode`;
    if (persist !== false) persistTheme(resolved);
}

function cycleTheme() {
    const order = Array.isArray(State.themeOrder) && State.themeOrder.length ? State.themeOrder : DEFAULT_THEME_ORDER;
    const currentIndex = order.indexOf(State.theme);
    const nextTheme = order[(currentIndex + 1) % order.length] || order[0];
    setTheme(nextTheme, true);
    renderShellState();
}

window.cycleTheme = cycleTheme;

function getProtectionSnapshot() {
    const condom = State.playerData.condom;
    const contraception = State.playerData.contraception;
    const protectedNow = !!(condom || contraception);
    return {
        safe: protectedNow,
        label: protectedNow ? 'Protected' : 'Unprotected',
        detail: condom ? `Condom ${timeUntil(condom.expires_at || condom)}` : contraception ? `Pill ${timeUntil(contraception.expires_at || contraception)}` : 'No active protection',
    };
}

window.getProtectionSnapshot = getProtectionSnapshot;

function renderShellState() {
    const chip = document.getElementById('protectionChip');
    const chipLabel = document.getElementById('protectionChipLabel');
    const protection = getProtectionSnapshot();
    if (chip) {
        chip.classList.remove('status-chip--warn', 'status-chip--safe');
        chip.classList.add(protection.safe ? 'status-chip--safe' : 'status-chip--warn');
        chip.title = protection.detail;
    }
    if (chipLabel) chipLabel.textContent = protection.label;

    const shell = document.getElementById('tabletShell');
    if (shell) shell.setAttribute('aria-hidden', State.open ? 'false' : 'true');
}

function setStandbyMode(enabled, notifyServer) {
    State.standby = !!enabled;
    const wakeScreen = document.getElementById('screenWake');
    if (wakeScreen) wakeScreen.classList.toggle('hidden', !State.standby);
    if (notifyServer) {
        nuiFetch('toggleStandby', { standby: State.standby }).catch(() => {});
    }
}

function toggleStandby() {
    if (!State.open) return;
    setStandbyMode(!State.standby, true);
}

window.toggleStandby = toggleStandby;

function openModal(id) {
    document.getElementById(id)?.classList.remove('hidden');
}

function closeModal(id) {
    document.getElementById(id)?.classList.add('hidden');
    if (id === 'confirmModal') {
        State.pendingConfirm = null;
    }
}

window.openModal = openModal;
window.closeModal = closeModal;

function openConfirmModal(title, body, onConfirm) {
    const titleNode = document.getElementById('confirmModalTitle');
    const bodyNode  = document.getElementById('confirmModalBody');
    let   actionNode = document.getElementById('confirmModalAction');
    if (titleNode) titleNode.textContent = title;
    if (bodyNode)  bodyNode.textContent  = body;
    if (actionNode) {
        // Clone the button to strip ALL previously stacked onclick handlers
        const fresh = actionNode.cloneNode(true);
        actionNode.parentNode.replaceChild(fresh, actionNode);
        actionNode = fresh;
        actionNode.onclick = () => {
            // Capture the callback BEFORE closeModal clears State.pendingConfirm
            const callback = State.pendingConfirm;
            closeModal('confirmModal');
            if (typeof callback === 'function') callback();
        };
    }
    State.pendingConfirm = typeof onConfirm === 'function' ? onConfirm : null;
    openModal('confirmModal');
}

window.openConfirmModal = openConfirmModal;

function showToast(message, type = 'inform') {
    const toast = document.getElementById('toast');
    if (!toast) return;

    if (type === 'success') playSound('success');
    if (type === 'error') playSound('error');

    toast.textContent = message;
    toast.className = `toast is-${type}`;
    toast.classList.remove('hidden');

    if (State.toastTimer) clearTimeout(State.toastTimer);
    State.toastTimer = window.setTimeout(() => {
        toast.classList.add('hidden');
    }, 4200);
}

window.showToast = showToast;

function buildViewerRows(rows) {
    return rows.map((row) => `
        <div class="detail-row">
            <span>${esc(row.label)}</span>
            <strong>${esc(row.value)}</strong>
        </div>
    `).join('');
}

window.buildViewerRows = buildViewerRows;

function showViewer(title, label, contentHtml) {
    const titleEl = document.getElementById('viewerTitle');
    const labelEl = document.getElementById('viewerLabel');
    const contentEl = document.getElementById('viewerContent');
    if (titleEl) titleEl.textContent = title;
    if (labelEl) labelEl.textContent = label;
    if (contentEl) contentEl.innerHTML = contentHtml;
    openModal('viewerModal');
}

window.showViewer = showViewer;

function showVitaminReminder() {
    document.getElementById('vitaminReminder')?.classList.remove('hidden');
}

function hideVitaminReminder() {
    document.getElementById('vitaminReminder')?.classList.add('hidden');
}

window.hideVitaminReminder = hideVitaminReminder;

function showUnregRequest(name, requesterSID) {
    State.pendingUnreg = { requesterSID: Number(requesterSID), name: name || 'Partner' };
    const text = document.getElementById('unregBannerText');
    if (text) text.textContent = `${State.pendingUnreg.name} wants to unregister your connection.`;
    document.getElementById('unregBanner')?.classList.remove('hidden');
}

function clearUnregRequest() {
    State.pendingUnreg = null;
    document.getElementById('unregBanner')?.classList.add('hidden');
}

function acceptUnreg() {
    if (!State.pendingUnreg) return;
    nuiFetch('acceptUnregister', { requesterSID: State.pendingUnreg.requesterSID });
    clearUnregRequest();
}

function declineUnreg() {
    if (!State.pendingUnreg) return;
    nuiFetch('declineUnregister', { requesterSID: State.pendingUnreg.requesterSID });
    clearUnregRequest();
}

window.acceptUnreg = acceptUnreg;
window.declineUnreg = declineUnreg;

function refreshActivePage() {
    if (!State.open) return;
    const page = aliasPage(State.currentPage);
    const renderers = {
        home: 'renderHomePage',
        animations: 'loadAnimationsPage',
        protection: 'renderProtectionPage',
        pregnancy: 'renderPregnancyPage',
        std: 'renderSTDPage',
        pharmacy: 'loadPharmacyPage',
        dna: 'renderDNAPage',
        childsupport: 'renderChildSupportPage',
        coffee: 'loadCoffeePage',
        brocode: 'loadBroCodePage',
        babyprofiles: 'renderBabyProfilesPage',
    };

    const fn = renderers[page] ? window[renderers[page]] : null;
    if (typeof fn === 'function') fn(false);
    updateRelativeTimers();
}

function setPageState(pageName, silent) {
    const nextPage = aliasPage(pageName);
    State.currentPage = nextPage;

    document.querySelectorAll('.page').forEach((page) => {
        page.classList.toggle('active', page.id === `page-${nextPage}`);
    });

    if (State.standby) setStandbyMode(false, false);
    refreshActivePage();
    if (!silent) playSound('open');
}

function showPage(pageName) {
    setPageState(pageName, false);
}

window.showPage = showPage;

function probeFeatureAccess() {
    nuiFetch('getCoffeeAccess').then((response) => {
        State.coffee.allowed = !!(response && response.allowed);
        if (State.open) refreshActivePage();
    }).catch(() => {});

    nuiFetch('getBroCodeAccess').then((response) => {
        State.brocode.allowed = !!(response && response.allowed);
        if (State.open) refreshActivePage();
    }).catch(() => {});
}

function openTabletUI() {
    const overlay = document.getElementById('overlay');
    mountStaticAssets();
    State.open = true;
    State.currentPage = 'home';
    setStandbyMode(false, false);
    overlay?.classList.remove('hidden');
    window.requestAnimationFrame(() => overlay?.classList.add('is-open'));
    playSound('open');
    startClock();
    startRelativeTimer();
    renderShellState();
    probeFeatureAccess();
    const initialPage = State.pendingGotoPage || 'home';
    State.pendingGotoPage = null;
    setPageState(initialPage, true);
}

function closeTabletUI() {
    State.open = false;
    State.pendingGotoPage = null;
    setStandbyMode(false, false);
    clearUnregRequest();
    hideVitaminReminder();
    stopClock();
    stopRelativeTimer();
    document.querySelectorAll('.modal').forEach((node) => node.classList.add('hidden'));
    const overlay = document.getElementById('overlay');
    overlay?.classList.remove('is-open');
    window.setTimeout(() => {
        if (!State.open) overlay?.classList.add('hidden');
    }, 220);
}

function closeTablet() {
    nuiFetch('closeTablet');
    closeTabletUI();
}

window.closeTablet = closeTablet;

function mergePlayerData(payload) {
    if (!payload || typeof payload !== 'object') return;

    Object.keys(payload).forEach((key) => {
        if (key === 'childSupport' && payload.childSupport && typeof payload.childSupport === 'object') {
            State.playerData.childSupportCases = payload.childSupport.cases || State.playerData.childSupportCases || [];
            State.playerData.childSupportSummary = payload.childSupport.summary || State.playerData.childSupportSummary || {};
            return;
        }
        State.playerData[key] = payload[key];
    });

    const tabletConfig = State.playerData.tablet || {};
    if (tabletConfig.soundDebounceMs) {
        State.sound.debounceMs = Number(tabletConfig.soundDebounceMs) || 90;
    }
    if (Array.isArray(tabletConfig.themeOrder) && tabletConfig.themeOrder.length) {
        State.themeOrder = tabletConfig.themeOrder.slice();
    }

    const selected = State.playerData.selectedPartnerState;
    if (selected && selected.serverId) {
        State.currentPartner = {
            serverId: Number(selected.serverId),
            name: selected.name || `Player #${selected.serverId}`,
        };
    } else if (selected === false) {
        State.currentPartner = null;
    }

    renderShellState();
    if (typeof window.renderHomePage === 'function') {
        window.renderHomePage();
    }
    // Always refresh active page when data arrives.
    // Don't gate on State.open — data can arrive during the open animation
    // before State.open is set to true, which causes the pregnancy page to
    // render with stale/empty data and show "Not Pregnant" incorrectly.
    refreshActivePage();
    updateRelativeTimers();
}

function showDNAResultViewer(data) {
    showViewer('DNA Result', 'Paternity Record', buildViewerRows([
        { label: 'Target', value: data?.targetName || 'Unknown' },
        { label: 'Match', value: `${Number(data?.matchPct || 0)}%` },
        { label: 'Tested At', value: formatDateTime(data?.testedAt) },
        { label: 'Verdict', value: Number(data?.matchPct || 0) >= 90 ? 'Confirmed Link' : 'No confirmed link' },
    ]));
}

function showBirthCertViewer(data) {
    showViewer('Birth Certificate', 'Birth Record', buildViewerRows([
        { label: 'Gender', value: data?.gender || 'Unknown' },
        { label: 'Other Parent', value: data?.partnerName || 'Unknown' },
        { label: 'Birth Date', value: formatDateTime(data?.birthAt) },
        { label: 'Conceived At', value: formatDateTime(data?.conceivedAt) },
    ]));
}

function showUltrasoundViewer(data) {
    showViewer('Ultrasound Report', 'Medical Imaging', buildViewerRows([
        { label: 'Gender', value: data?.gender || 'Unknown' },
        { label: 'Weeks', value: data?.weeksPregnant != null ? String(data.weeksPregnant) : 'Unknown' },
        { label: 'Due Date', value: formatDateTime(data?.birthAt) },
        { label: 'Scanned At', value: formatDateTime(data?.scannedAt) },
        { label: 'Report Age', value: data?.daysSinceScan != null ? `${data.daysSinceScan} day(s)` : 'Fresh report' },
    ]));
}

window.addEventListener('message', (event) => {
    const payload = event.data || {};
    switch (payload.action) {
        case 'openTablet':
            openTabletUI();
            break;
        case 'closeTablet':
            closeTabletUI();
            break;
        case 'setPlayerData':
        case 'updateData':
            mergePlayerData(payload.data || {});
            break;
        case 'toast':
            showToast(payload.message || 'Update received.', payload.ntype || 'inform');
            break;
        case 'unregRequest':
            showUnregRequest(payload.name, payload.requesterSID);
            break;
        case 'unregTimeout':
            clearUnregRequest();
            break;
        case 'gotoPage':
            if (State.open) {
                showPage(payload.page);
            } else {
                State.pendingGotoPage = aliasPage(payload.page);
            }
            break;
        case 'showDNAResult':
            showDNAResultViewer(payload.data || {});
            break;
        case 'showBirthCert':
            showBirthCertViewer(payload.data || {});
            break;
        case 'showUltrasound':
            showUltrasoundViewer(payload.data || {});
            break;
        case 'vitaminReminder':
            showVitaminReminder();
            break;
        case 'previewCancelled':
            showToast('Preview cancelled.', 'inform');
            break;
        default:
            break;
    }
});

document.addEventListener('keydown', (event) => {
    if (!State.open) return;
    if (event.key === 'Escape') {
        closeTablet();
        return;
    }
    if (State.standby && (event.key === 'Enter' || event.key === ' ')) {
        event.preventDefault();
        toggleStandby();
    }
});

document.addEventListener('DOMContentLoaded', () => {
    preloadSounds();
    bindGlobalClickSound();
    mountStaticAssets();
    const storedTheme = getStoredTheme();
    setTheme(storedTheme || 'pink', false);
    renderShellState();
});

