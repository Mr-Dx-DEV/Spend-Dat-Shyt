'use strict';

const APP_ICONS = {
    animations:   { asset: 'html/assets/grim_logo.png', fallback: '🎭' },
    protection:   { asset: 'html/assets/grim_logo.png', fallback: '🛡️' },
    pregnancy:    { asset: 'html/assets/grim_logo.png', fallback: '🤰' },
    std:          { asset: 'html/assets/grim_logo.png', fallback: '🧫' },
    pharmacy:     { asset: 'html/assets/grim_logo.png', fallback: '💊' },
    dna:          { asset: 'html/assets/grim_logo.png', fallback: '🧬' },
    childsupport: { asset: 'html/assets/grim_logo.png', fallback: '👶' },
    coffee:       { asset: 'html/assets/grim_logo.png', fallback: '☕' },
    brocode:      { asset: 'html/assets/grim_logo.png', fallback: '🤝' },
    babyprofiles: { asset: 'html/assets/grim_logo.png', fallback: '🍼' },
};

const HOME_APPS = [
    { key: 'animations', label: 'Animations', page: 'animations' },
    { key: 'protection', label: 'Protection', page: 'protection' },
    { key: 'pregnancy', label: 'Pregnancy Tracker', page: 'pregnancy' },
    { key: 'std', label: 'STD Testing', page: 'std' },
    { key: 'pharmacy', label: 'Pharmacy', page: 'pharmacy' },
    { key: 'dna', label: 'DNA Test', page: 'dna' },
    { key: 'childsupport', label: 'Child Support', page: 'childsupport' },
    { key: 'coffee', label: 'Coffee', page: 'coffee' },
    { key: 'brocode', label: 'Bro Code', page: 'brocode' },
    { key: 'babyprofiles', label: 'Baby Profiles', page: 'babyprofiles' },
];

function renderEmptyState(message) {
    return `<div class="empty-state">${esc(message)}</div>`;
}

function buildStatePill(state) {
    const normalized = String(state || 'neutral').toLowerCase();
    const safeState = ['ready', 'completed', 'locked'].includes(normalized) ? normalized : 'neutral';
    const label = safeState.charAt(0).toUpperCase() + safeState.slice(1);
    return `<span class="status-pill status-${safeState}">${esc(label)}</span>`;
}

function buildMediaBadge(key, className = 'app-card__media') {
    const icon = APP_ICONS[key] || { asset: 'html/assets/grim_logo.png', fallback: 'GL' };
    return `
        <div class="${className}">
            <img src="${esc(resourceAsset(icon.asset))}" alt="${esc(key)} icon" onerror="handleAssetError(this)" />
            <span class="asset-fallback">${esc(icon.fallback)}</span>
        </div>
    `;
}

function pageHeader(page, title, copy) {
    return `
        <div class="page-header">
            <div class="page-header__left">
                <button class="back-button" type="button" data-sound="open" onclick="showPage('home')">Home</button>
                <div>
                    <p class="eyebrow">Love Menu App</p>
                    <h2 class="page-header__title">${esc(title)}</h2>
                    <p class="page-header__copy">${esc(copy)}</p>
                </div>
            </div>
            <div class="meta-row">
                <span class="summary-pill">${esc(page)}</span>
            </div>
        </div>
    `;
}

function getPregnancyRecord() {
    const pregnancy = State.playerData.pregnancy;
    if (!pregnancy || pregnancy === false || pregnancy.born) return null;
    return pregnancy;
}

function getRegisteredPartners() {
    return Array.isArray(State.playerData.registeredPartners) ? State.playerData.registeredPartners : [];
}

function getBabyProfiles() {
    return Array.isArray(State.playerData.babyProfiles) ? State.playerData.babyProfiles : [];
}

function getChildSupportCases() {
    return Array.isArray(State.playerData.childSupportCases) ? State.playerData.childSupportCases : [];
}

function timeLeftLabel(record) {
    const value = record && record.expires_at ? record.expires_at : record;
    return timeUntil(value);
}

function getFeatureSettings() {
    return State.playerData.settings || {};
}

function getPregnancySettings() {
    return getFeatureSettings().pregnancy || {};
}

function getPharmacySettings() {
    return getFeatureSettings().pharmacy || {};
}

function formatDurationLabel(days, hours) {
    const parts = [];
    const safeDays = Number(days) || 0;
    const safeHours = Number(hours) || 0;

    if (safeDays > 0) {
        parts.push(`${safeDays} day${safeDays === 1 ? '' : 's'}`);
    }

    if (safeHours > 0) {
        parts.push(`${safeHours} hour${safeHours === 1 ? '' : 's'}`);
    }

    return parts.length ? parts.join(' ') : '0 hours';
}

function buildLiveCountdown(value, precise = false) {
    const safeValue = esc(value || '');
    return `<span data-time-until="${safeValue}" data-time-precision="${precise ? 'true' : 'false'}">${esc(timeUntil(value, precise))}</span>`;
}

function resolveAppMeta(key) {
    const pregnancy = getPregnancyRecord();
    const profiles = getBabyProfiles();
    const supportCases = getChildSupportCases();
    const stdRows = Array.isArray(State.playerData.std) ? State.playerData.std : [];
    const readyClaims = supportCases.filter((entry) => entry.eligible).length;
    const selectedPartner = State.currentPartner || (State.playerData.selectedPartnerState && State.playerData.selectedPartnerState.serverId ? State.playerData.selectedPartnerState : null);
    const pregnancySettings = getPregnancySettings();
    const pharmacySettings = getPharmacySettings();

    switch (key) {
        case 'animations':
            return {
                state: selectedPartner ? 'ready' : 'locked',
                subtitle: selectedPartner ? `${selectedPartner.name || 'Partner'} linked for synced scenes.` : 'Select a nearby partner to unlock synced scenes.',
            };
        case 'protection':
            return {
                state: State.playerData.condom || State.playerData.contraception ? 'completed' : 'ready',
                subtitle: State.playerData.condom || State.playerData.contraception ? getProtectionSnapshot().detail : 'Condoms, pills, vitamins, and readiness controls.',
            };
        case 'pregnancy':
            if (!pregnancy && pregnancySettings.allowed === false) return { state: 'locked', subtitle: 'Pregnancy access is role-locked.' };
            if (pregnancy && pregnancy.birthReady) return { state: 'completed', subtitle: 'Birth is ready now.' };
            if (pregnancy) return { state: 'ready', subtitle: `Due ${formatShortDate(pregnancy.birthAt)}.` };
            return { state: 'ready', subtitle: `${formatDurationLabel(pregnancySettings.durationDays, pregnancySettings.durationHours)} default term.` };
        case 'std':
            return {
                state: stdRows.length ? 'ready' : 'completed',
                subtitle: stdRows.length ? `${stdRows.length} active condition${stdRows.length === 1 ? '' : 's'} found.` : 'No active STD records.',
            };
        case 'pharmacy':
            if (pharmacySettings.enabled === false) return { state: 'locked', subtitle: 'Pharmacy access is disabled in config.' };
            if (pharmacySettings.allowed === false) return { state: 'locked', subtitle: 'Pharmacy access is role-locked.' };
            return { state: 'ready', subtitle: 'Medication, Plan C, DNA kits, and protection supplies.' };
        case 'dna': {
            const dnaComplete = (pregnancy && pregnancy.dnaConfirmed) || profiles.some((profile) => profile.dnaConfirmed);
            return {
                state: dnaComplete ? 'completed' : 'ready',
                subtitle: dnaComplete ? 'DNA records confirmed.' : 'Run a test to verify paternity links.',
            };
        }
        case 'childsupport':
            if (readyClaims > 0) return { state: 'ready', subtitle: `${readyClaims} payout claim${readyClaims === 1 ? '' : 's'} ready.` };
            if (supportCases.length > 0 && supportCases.every((entry) => entry.childSupportClaimed)) return { state: 'completed', subtitle: 'All linked payouts are already claimed.' };
            return { state: supportCases.length ? 'locked' : 'ready', subtitle: supportCases.length ? 'Cases exist but remain locked by checks.' : 'No cases linked yet.' };
        case 'coffee':
            return {
                state: State.coffee.allowed === false ? 'locked' : 'ready',
                subtitle: State.coffee.allowed === false ? 'Coffee is unavailable for this current ped setup.' : 'Social feed, posts, and comments.',
            };
        case 'brocode':
            return {
                state: State.brocode.allowed === false ? 'locked' : 'ready',
                subtitle: State.brocode.allowed === false ? 'Bro Code is unavailable for this current ped setup.' : 'Live posts, media, and comments.',
            };
        case 'babyprofiles':
            if (!profiles.length) return { state: 'locked', subtitle: 'Profiles unlock after birth is confirmed.' };
            if (profiles.every((profile) => profile.dnaConfirmed && profile.childSupportClaimed)) return { state: 'completed', subtitle: `${profiles.length} fully processed baby profile${profiles.length === 1 ? '' : 's'}.` };
            return { state: 'ready', subtitle: `${profiles.length} baby profile${profiles.length === 1 ? '' : 's'} synced to the tablet.` };
        default:
            return { state: 'ready', subtitle: 'Ready.' };
    }
}

function renderHomePage() {
    const container = document.getElementById('home-page-content');
    if (!container) return;

    const pregnancy = getPregnancyRecord();
    const supportCases = getChildSupportCases();
    const profiles = getBabyProfiles();
    const stdRows = Array.isArray(State.playerData.std) ? State.playerData.std : [];
    const heroText = pregnancy && pregnancy.birthReady
        ? 'Birth is ready. Open the tracker, finish delivery, and sync the baby profile.'
        : pregnancy
            ? 'Your pregnancy tracker is live. Monitor birth timing, DNA status, vitamins, and child support readiness.'
            : 'A premium Love Menu tablet with partner tools, pregnancy systems, DNA records, pharmacy access, and restored premium apps.';

    const appCards = HOME_APPS.map((app) => {
        const meta = resolveAppMeta(app.key);
        return `
            <button class="app-card" type="button" onclick="showPage('${esc(app.page)}')" data-sound="open">
                ${buildMediaBadge(app.key)}
                <div class="app-card__body">
                    <h3 class="app-card__title">${esc(app.label)}</h3>
                    <p class="app-card__copy">${esc(meta.subtitle)}</p>
                </div>
                <div class="app-card__footer">
                    ${buildStatePill(meta.state)}
                    <span class="summary-pill">Open</span>
                </div>
            </button>
        `;
    }).join('');

    container.innerHTML = `
        <div class="page-shell">
            <section class="hero-panel">
                <div class="hero-panel__copy">
                    <div>
                        <p class="eyebrow">Premium Tablet</p>
                        <h1 class="hero-panel__title">Love Menu</h1>
                    </div>
                    <p class="hero-panel__text">${esc(heroText)}</p>
                    <div class="meta-row">
                        <span class="summary-pill">${esc(getProtectionSnapshot().label)}</span>
                        <span class="summary-pill">${esc(THEME_LABELS[State.theme] || 'Theme')}</span>
                        <span class="summary-pill">${profiles.length} Baby Profile${profiles.length === 1 ? '' : 's'}</span>
                    </div>
                </div>
                <div class="hero-panel__logo">
                    <img src="${esc(resourceAsset('html/assets/grim_logo.png'))}" alt="Grim Development logo" onerror="handleAssetError(this)" />
                    <span class="logo-fallback">Grim Development</span>
                </div>
            </section>

            <section class="metrics-strip">
                <article class="metric-tile"><span class="metric-tile__value">${pregnancy ? '1' : '0'}</span><span class="metric-tile__label">Active Pregnancy</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${supportCases.filter((entry) => entry.eligible).length}</span><span class="metric-tile__label">Ready Claims</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${profiles.length}</span><span class="metric-tile__label">Baby Profiles</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${stdRows.length}</span><span class="metric-tile__label">STD Alerts</span></article>
            </section>

            <section class="app-grid">
                ${appCards}
            </section>
        </div>
    `;
}

window.renderHomePage = renderHomePage;

async function loadAnimationsPage(forceRefresh) {
    if (!State.animations.loaded || forceRefresh === true) {
        const response = await nuiFetch('getAnimList');
        State.animations.list = Array.isArray(response?.animations) ? response.animations : [];
        State.animations.loaded = true;
    }
    renderAnimationsPage();
}

window.loadAnimationsPage = loadAnimationsPage;

function setAnimFilter(filter) {
    State.animations.filter = filter || 'all';
    renderAnimationsPage();
}

window.setAnimFilter = setAnimFilter;

function toggleAnimationDebug() {
    State.animations.debug = !State.animations.debug;
    renderAnimationsPage();
}

window.toggleAnimationDebug = toggleAnimationDebug;

function setAnimationFinishMode(mode) {
    State.animations.finishMode = mode === 'pullout' ? 'pullout' : 'finish';
    renderAnimationsPage();
}

window.setAnimationFinishMode = setAnimationFinishMode;

function startAnimation(animId) {
    nuiFetch('startAnim', {
        animId: Number(animId),
        finishMode: State.animations.finishMode,
        debug: State.animations.debug,
    });
}

window.startAnimation = startAnimation;

function renderAnimationsPage() {
    const container = document.getElementById('animations-page-content');
    if (!container) return;

    const selectedPartner = State.currentPartner;
    const animations = Array.isArray(State.animations.list) ? State.animations.list : [];
    const activeFilter = State.animations.filter || 'all';
    const filtered = animations.filter((animation) => activeFilter === 'all' || animation.category === activeFilter);

    const cards = filtered.length ? filtered.map((animation) => {
        const category = animation.category || 'general';
        const tagLabel = category === 'vehicle' ? 'Vehicle' : category === 'floor' ? 'Floor' : 'Standing';
        const actionLabel = category === 'vehicle' ? 'In car' : State.animations.debug ? 'Debug' : 'Start';
        return `
            <article class="anim-card">
                <div class="anim-card__body">
                    ${buildMediaBadge('animations', 'anim-card__media')}
                    <div>
                        <div class="anim-card__tags">
                            <span class="meta-pill">${esc(tagLabel)}</span>
                            <span class="meta-pill">Partner</span>
                        </div>
                        <h3 class="anim-card__title">${esc(animation.label || 'Animation')}</h3>
                        <p class="anim-card__copy">${esc(animation.desc || 'Partner-required synced animation.')}</p>
                    </div>
                </div>
                <div class="anim-card__footer">
                    <button class="primary-button" type="button" ${selectedPartner ? '' : 'disabled'} onclick="startAnimation(${Number(animation.id)})">${esc(actionLabel)}</button>
                    <span class="summary-pill">${esc(State.animations.finishMode === 'pullout' ? 'Pull Out' : 'Finish')}</span>
                </div>
            </article>
        `;
    }).join('') : renderEmptyState('No animations matched the current filter.');

    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('Animations', 'Animations', 'Restored synced scenes, partner selection, finish mode, and the old larger layout.')}

            <div class="card-grid">
                <article class="panel-card">
                    <div class="panel-card__head">
                        <div>
                            <p class="eyebrow">Partner</p>
                            <h3 class="summary-card__title">Selected partner</h3>
                        </div>
                        <button class="ghost-button" type="button" onclick="openPartnerPicker('relationship')">Change</button>
                    </div>
                    <p class="panel-card__copy">${esc(selectedPartner ? `${selectedPartner.name} (#${selectedPartner.serverId}) is linked for synced scenes.` : 'No partner selected. Choose a nearby partner to unlock synced scenes.')}</p>
                    <div class="panel-card__footer">
                        ${buildStatePill(selectedPartner ? 'ready' : 'locked')}
                        <span class="summary-pill">${esc(selectedPartner ? `#${selectedPartner.serverId}` : 'Nearby only')}</span>
                    </div>
                </article>

                <article class="panel-card">
                    <div class="panel-card__head">
                        <div>
                            <p class="eyebrow">Finish Mode</p>
                            <h3 class="summary-card__title">Scene outcome</h3>
                        </div>
                    </div>
                    <div class="choice-grid">
                        <button class="choice-card ${State.animations.finishMode === 'finish' ? 'active' : ''}" type="button" onclick="setAnimationFinishMode('finish')">
                            <span class="choice-card__title">Finish</span>
                            <span class="choice-card__copy">Normal restored finish flow.</span>
                        </button>
                        <button class="choice-card ${State.animations.finishMode === 'pullout' ? 'active' : ''}" type="button" onclick="setAnimationFinishMode('pullout')">
                            <span class="choice-card__title">Pull Out</span>
                            <span class="choice-card__copy">Starts the scene in pull-out mode.</span>
                        </button>
                    </div>
                </article>
            </div>

            <div class="filter-row">
                <div class="filter-row">
                    <button class="filter-chip ${activeFilter === 'all' ? 'active' : ''}" type="button" onclick="setAnimFilter('all')">All</button>
                    <button class="filter-chip ${activeFilter === 'standing' ? 'active' : ''}" type="button" onclick="setAnimFilter('standing')">Standing</button>
                    <button class="filter-chip ${activeFilter === 'floor' ? 'active' : ''}" type="button" onclick="setAnimFilter('floor')">Floor</button>
                    <button class="filter-chip ${activeFilter === 'vehicle' ? 'active' : ''}" type="button" onclick="setAnimFilter('vehicle')">Vehicle</button>
                </div>
                <button class="filter-chip ${State.animations.debug ? 'active' : ''}" type="button" onclick="toggleAnimationDebug()">Debug</button>
            </div>

            <section class="anim-grid">
                ${cards}
            </section>
        </div>
    `;
}

function renderProtectionPage() {
    const container = document.getElementById('protection-page-content');
    if (!container) return;

    const condom = State.playerData.condom ? timeLeftLabel(State.playerData.condom) : 'Inactive';
    const contraception = State.playerData.contraception ? timeLeftLabel(State.playerData.contraception) : 'Inactive';
    const vitamins = State.playerData.vitamins ? timeLeftLabel(State.playerData.vitamins) : 'Inactive';
    const pregnancySettings = getPregnancySettings();

    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('Protection', 'Protection', 'Quick-use protection, medication windows, and readiness from the restored tablet flow.')}

            <section class="metrics-strip">
                <article class="metric-tile"><span class="metric-tile__value">${esc(condom)}</span><span class="metric-tile__label">Condom Window</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${esc(contraception)}</span><span class="metric-tile__label">Contraception</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${esc(vitamins)}</span><span class="metric-tile__label">Vitamins</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${esc(getProtectionSnapshot().label)}</span><span class="metric-tile__label">Current Status</span></article>
            </section>

            <section class="card-grid">
                <article class="status-card">
                    <div class="panel-card__head">
                        <div>
                            <p class="eyebrow">Quick Actions</p>
                            <h3 class="status-card__title">Use protection</h3>
                        </div>
                    </div>
                    <div class="button-row">
                        <button class="primary-button" type="button" onclick="useCondomsNow()">Use Condoms</button>
                        <button class="ghost-button" type="button" onclick="useContraceptionNow()">Take Contraception</button>
                        <button class="ghost-button" type="button" onclick="usePrenatalVitamins()">Take Vitamins</button>
                    </div>
                    <p class="status-card__copy">The restored protection app mirrors live condom, contraception, and vitamin windows directly from the server. Vitamins last ${esc(formatDurationLabel(0, pregnancySettings.vitaminDoseHours || 3))} per dose.</p>
                </article>

                <article class="status-card">
                    <div class="panel-card__head">
                        <div>
                            <p class="eyebrow">Pharmacy</p>
                            <h3 class="status-card__title">Medical supplies</h3>
                        </div>
                        <button class="ghost-button" type="button" data-sound="open" onclick="showPage('pharmacy')">Open Pharmacy</button>
                    </div>
                    <p class="status-card__copy">Buy condoms, pills, Plan C, DNA kits, prescriptions, and testing items without leaving the tablet flow.</p>
                </article>
            </section>
        </div>
    `;
}

window.renderProtectionPage = renderProtectionPage;

function usePregnancyTest() { nuiFetch('usePregnancyTest'); }
function usePrenatalVitamins() { nuiFetch('usePrenatalVitamins'); }
function requestUltrasoundReport() { nuiFetch('requestUltrasound'); }
function usePlanC() { nuiFetch('usePlanC'); }
function giveBirthNow() { nuiFetch('giveBirth'); }
function useCondomsNow() { nuiFetch('useCondoms'); }
function useContraceptionNow() { nuiFetch('useContraception'); }
function useSTDTestNow() { nuiFetch('useSTDTest'); }
function usePrescriptionNow() { nuiFetch('usePrescription'); }
function refreshTabletData() { nuiFetch('getMyData'); }

window.usePregnancyTest = usePregnancyTest;
window.usePrenatalVitamins = usePrenatalVitamins;
window.requestUltrasoundReport = requestUltrasoundReport;
window.usePlanC = usePlanC;
window.giveBirthNow = giveBirthNow;
window.useCondomsNow = useCondomsNow;
window.useContraceptionNow = useContraceptionNow;
window.useSTDTestNow = useSTDTestNow;
window.usePrescriptionNow = usePrescriptionNow;
window.refreshTabletData = refreshTabletData;

function renderPregnancyPage() {
    // Always pull fresh server data when the pregnancy page is opened
    nuiFetch('getMyData');
    const container = document.getElementById('pregnancy-page-content');
    if (!container) return;

    const pregnancy          = getPregnancyRecord();
    const pregnancySettings  = getPregnancySettings();
    const vitamins           = State.playerData.vitamins;
    const vitActive          = !!(vitamins);
    const vitLabel           = vitActive ? `Active — ${timeLeftLabel(vitamins)} left` : 'Not active';

    // Progress bar calculation
    let progressPct = 0;
    let stageLabel  = 'EARLY DAYS';
    let stageDesc   = 'Your journey is just beginning ✨';
    let dueLine     = '';

    if (pregnancy && !pregnancy.birthReady) {
        const conceived  = toDate(pregnancy.conceivedAt);
        const birthDate  = toDate(pregnancy.birthAt);
        const settings   = getPregnancySettings();
        const termMs     = ((settings.durationDays || 7) * 86400 + (settings.durationHours || 0) * 3600) * 1000;

        if (birthDate) {
            // If conceivedAt is missing, back-calculate it from birthAt minus the term length
            const conceivedMs = conceived
                ? conceived.getTime()
                : birthDate.getTime() - termMs;
            const total   = birthDate.getTime() - conceivedMs;
            const elapsed = Date.now() - conceivedMs;
            progressPct   = total > 0 ? Math.min(100, Math.max(0, Math.round((elapsed / total) * 100))) : 0;
            if (progressPct < 25)       { stageLabel = 'EARLY DAYS';    stageDesc = 'Your journey is just beginning ✨'; }
            else if (progressPct < 50)  { stageLabel = 'GROWING';       stageDesc = 'Things are progressing well 🌱'; }
            else if (progressPct < 75)  { stageLabel = 'HALFWAY THERE'; stageDesc = 'More than halfway through 💪'; }
            else if (progressPct < 90)  { stageLabel = 'DUE SOON';      stageDesc = 'Getting close to delivery 🌸'; }
            else                        { stageLabel = 'NEARLY READY';  stageDesc = 'Birth is coming very soon 🍼'; }
            const remaining = timeUntil(pregnancy.birthAt, false);
            dueLine = (!remaining || remaining === 'Inactive' || remaining === 'Ready now') ? 'Due Now' : `In ${remaining}`;
        } else {
            dueLine = 'Calculating...';
        }
    } else if (pregnancy && pregnancy.birthReady) {
        progressPct = 100;
        stageLabel  = 'BIRTH READY';
        stageDesc   = 'Time to deliver! 🍼';
        dueLine     = 'Now';
    }

    const genderEmoji = pregnancy && pregnancy.gender === 'boy' ? '💙' : pregnancy && pregnancy.gender === 'girl' ? '🩷' : '';
    const genderText  = pregnancy && pregnancy.gender ? `Baby is ${genderEmoji} a ${pregnancy.gender}` : '';
    const dueShort    = pregnancy && pregnancy.birthAt ? `· Due ${formatShortDate(pregnancy.birthAt)}` : '';

    container.innerHTML = `
        <div class="page-shell preg-shell">
            <div class="preg-topbar">
                <button class="back-button" type="button" onclick="showPage('home')">‹ Home</button>
                <span class="preg-page-title">🌸 Pregnancy</span>
            </div>

            ${pregnancy ? `
            <section class="preg-status-card">
                <div class="preg-status-top">
                    <span class="preg-status-icon">🤰</span>
                    <div>
                        <div class="preg-status-title">Pregnant 💕</div>
                        ${genderText || dueShort ? `<div class="preg-status-sub">${esc(genderText)}${genderText && dueShort ? ' ' : ''}${esc(dueShort)}</div>` : ''}
                    </div>
                </div>
            </section>

            <section class="preg-progress-card">
                <div class="preg-stage-row">
                    <span class="preg-stage-icon">🌱</span>
                    <div>
                        <div class="preg-stage-label">${esc(stageLabel)}</div>
                        <div class="preg-stage-desc">${esc(stageDesc)}</div>
                    </div>
                </div>
                <div class="preg-bar-wrap">
                    <div class="preg-bar-track">
                        <div class="preg-bar-fill" style="width:${progressPct}%"></div>
                    </div>
                    <span class="preg-bar-pct">${progressPct}%</span>
                </div>
                <div class="preg-milestones">
                    <span>🌱<br><small>Conceived</small></span>
                    <span>🥚<br><small>Halfway</small></span>
                    <span>🌸<br><small>Due Soon</small></span>
                    <span>🍼<br><small>Birth Day</small></span>
                </div>
                <div class="preg-due-row">
                    <span class="preg-due-label">DUE DATE</span>
                    <span class="preg-due-value">${esc(dueLine)}</span>
                </div>
            </section>` : `
            <section class="preg-status-card">
                <div class="preg-status-top">
                    <span class="preg-status-icon">🩺</span>
                    <div>
                        <div class="preg-status-title">Not Pregnant</div>
                        <div class="preg-status-sub">${esc(pregnancySettings.allowed === false ? 'Pregnancy access is role-locked.' : `Default term: ${formatDurationLabel(pregnancySettings.durationDays || 7, pregnancySettings.durationHours || 0)}`)}</div>
                    </div>
                </div>
            </section>`}

            <section class="preg-vitamins-card">
                <div class="preg-vit-header">🌿 PRENATAL VITAMINS</div>
                <div class="preg-vit-status">
                    <span class="preg-vit-dot ${vitActive ? 'preg-vit-dot--on' : ''}"></span>
                    <span class="preg-vit-label">${esc(vitLabel)}</span>
                </div>
                <div class="preg-vit-hint">Take every 3h while pregnant. −5% pregnancy risk per dose.</div>
            </section>

            <section class="preg-actions">
                <button class="preg-action-btn" type="button" onclick="usePregnancyTest()">
                    <span class="preg-action-icon">🔬</span>
                    <span class="preg-action-name">Preg. Test</span>
                    <span class="preg-action-sub">Uses 1 kit</span>
                </button>
                <button class="preg-action-btn" type="button" onclick="usePrenatalVitamins()">
                    <span class="preg-action-icon">🌿</span>
                    <span class="preg-action-name">Vitamins</span>
                    <span class="preg-action-sub">3h dose</span>
                </button>
                <button class="preg-action-btn" type="button" onclick="requestUltrasoundReport()">
                    <span class="preg-action-icon">📋</span>
                    <span class="preg-action-name">Ultrasound</span>
                    <span class="preg-action-sub">Get report</span>
                </button>
                <button class="preg-action-btn" type="button" onclick="runDNATest()">
                    <span class="preg-action-icon">🧬</span>
                    <span class="preg-action-name">DNA Test</span>
                    <span class="preg-action-sub">Paternity</span>
                </button>
                <button class="preg-action-btn ${pregnancy && pregnancy.birthReady ? 'preg-action-btn--ready' : ''}" type="button" onclick="giveBirthNow()" ${pregnancy && pregnancy.birthReady ? '' : 'disabled'}>
                    <span class="preg-action-icon">🍼</span>
                    <span class="preg-action-name">Give Birth</span>
                    <span class="preg-action-sub">${pregnancy && pregnancy.birthReady ? 'Ready!' : 'When ready'}</span>
                </button>
            </section>
        </div>
    `;
}

window.renderPregnancyPage = renderPregnancyPage;

function renderSTDPage() {
    const container = document.getElementById('std-page-content');
    if (!container) return;

    const stdRows = Array.isArray(State.playerData.std) ? State.playerData.std : [];
    const list = stdRows.length ? stdRows.map((row) => {
        const label = row.label || row.disease_label || row.disease_id || row.disease || 'Condition';
        const treated = Number(row.cured || 0) === 1 ? 'Treated' : 'Active';
        return `
            <article class="feed-card">
                <div class="feed-card__body">
                    <h3 class="feed-card__title">${esc(label)}</h3>
                    <p class="feed-card__copy">Current status: ${esc(treated)}.</p>
                </div>
                <div class="feed-card__footer">
                    ${buildStatePill(treated === 'Active' ? 'ready' : 'completed')}
                    <span class="summary-pill">Monitor</span>
                </div>
            </article>
        `;
    }).join('') : renderEmptyState('No active STD records found.');

    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('STD Testing', 'STD Testing', 'Restored testing, prescription access, and health status feedback.')}
            <section class="metrics-strip">
                <article class="metric-tile"><span class="metric-tile__value">${stdRows.length}</span><span class="metric-tile__label">Active Conditions</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${stdRows.length ? 'Check' : 'Clean'}</span><span class="metric-tile__label">Current Readout</span></article>
                <article class="metric-tile"><span class="metric-tile__value">Kit</span><span class="metric-tile__label">Testing From Tablet</span></article>
                <article class="metric-tile"><span class="metric-tile__value">Rx</span><span class="metric-tile__label">Prescription Support</span></article>
            </section>

            <section class="card-grid">
                <article class="status-card">
                    <div class="panel-card__head"><div><p class="eyebrow">Actions</p><h3 class="status-card__title">Testing and treatment</h3></div></div>
                    <div class="button-row">
                        <button class="primary-button" type="button" onclick="useSTDTestNow()">Use STD Test Kit</button>
                        <button class="ghost-button" type="button" onclick="usePrescriptionNow()">Use Prescription</button>
                        <button class="ghost-button" type="button" onclick="showPage('pharmacy')">Open Pharmacy</button>
                    </div>
                </article>

                <article class="status-card">
                    <div class="panel-card__head"><div><p class="eyebrow">Results</p><h3 class="status-card__title">Current records</h3></div></div>
                    <div class="status-grid">${list}</div>
                </article>
            </section>
        </div>
    `;
}

window.renderSTDPage = renderSTDPage;

function renderDNAPage() {
    const container = document.getElementById('dna-page-content');
    if (!container) return;

    const pregnancy = getPregnancyRecord();
    const profiles = getBabyProfiles();
    const dnaReadyProfiles = profiles.filter((profile) => !profile.dnaConfirmed);
    const target = State.dnaTarget || State.currentPartner;

    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('DNA Test', 'DNA Test', 'Restored DNA routing, item integration, paternity checks, and baby-link syncing.')}

            <section class="hero-panel">
                <div class="hero-panel__copy">
                    <div><p class="eyebrow">DNA Status</p><h2 class="hero-panel__title">${esc(pregnancy && pregnancy.dnaConfirmed ? 'Confirmed pregnancy DNA' : 'DNA verification ready')}</h2></div>
                    <p class="hero-panel__text">${esc(pregnancy && pregnancy.dnaConfirmed ? 'The active pregnancy is already linked with a confirmed DNA result.' : 'Choose a nearby player and run the DNA kit from the restored DNA app.')}</p>
                    <div class="meta-row">
                        ${buildStatePill(pregnancy && pregnancy.dnaConfirmed ? 'completed' : 'ready')}
                        <span class="summary-pill">${profiles.filter((profile) => profile.dnaConfirmed).length} Confirmed Profile${profiles.filter((profile) => profile.dnaConfirmed).length === 1 ? '' : 's'}</span>
                    </div>
                </div>
                ${buildMediaBadge('dna', 'hero-panel__logo')}
            </section>

            <section class="card-grid">
                <article class="status-card">
                    <div class="panel-card__head"><div><p class="eyebrow">DNA Target</p><h3 class="status-card__title">Selected player</h3></div></div>
                    <p class="status-card__copy">${esc(target ? `${target.name} (#${target.serverId})` : 'No DNA target selected.')}</p>
                    <div class="button-row">
                        <button class="ghost-button" type="button" onclick="openPartnerPicker('dna')">Choose Target</button>
                        <button class="primary-button" type="button" onclick="runDNATest()">Run DNA Test</button>
                    </div>
                </article>

                <article class="status-card">
                    <div class="panel-card__head"><div><p class="eyebrow">Pending Links</p><h3 class="status-card__title">Profiles waiting on DNA</h3></div></div>
                    ${dnaReadyProfiles.length ? `<div class="profile-list">${dnaReadyProfiles.map((profile) => `<div class="info-pill">${esc(profile.childName || profile.childId)} • Father ${esc(profile.fatherName || profile.fatherCitizenId || 'Unknown')}</div>`).join('')}</div>` : '<div class="empty-state">No baby profiles are waiting on DNA confirmation.</div>'}
                </article>
            </section>
        </div>
    `;
}

window.renderDNAPage = renderDNAPage;

async function openPartnerPicker(mode) {
    State.partnerPickerMode = mode || 'relationship';
    const modalTitle = document.getElementById('partnerModalTitle');
    const list = document.getElementById('partnerPickerList');
    if (!list) return;
    if (modalTitle) modalTitle.textContent = State.partnerPickerMode === 'dna' ? 'Select DNA target' : 'Select partner';

    const response = await nuiFetch('getPartners');
    const partners = Array.isArray(response) ? response : (response && response.partners) || [];

    if (!partners.length) {
        list.innerHTML = renderEmptyState('No nearby players are currently available.');
        openModal('partnerModal');
        return;
    }

    list.innerHTML = partners.map((partner) => `
        <button class="picker-item" type="button" data-name="${esc(partner.name || `Player #${partner.serverId}`)}" onclick="selectPartnerOption(${Number(partner.serverId)}, this.dataset.name)">
            <div>
                <strong>${esc(partner.name || `Player #${partner.serverId}`)}</strong>
                <div class="feed-meta">#${Number(partner.serverId)} • ${esc(partner.registered ? 'Registered' : `${Math.floor(Number(partner.dist || 0))}m away`)}</div>
            </div>
            ${buildStatePill(partner.registered ? 'completed' : 'ready')}
        </button>
    `).join('');

    openModal('partnerModal');
}

window.openPartnerPicker = openPartnerPicker;

async function selectPartnerOption(serverId, name) {
    closeModal('partnerModal');
    const partner = { serverId: Number(serverId), name: String(name || '') };
    if (State.partnerPickerMode === 'dna') {
        State.dnaTarget = partner;
        refreshActivePage();
        return;
    }
    await nuiFetch('selectPartner', partner);
    State.currentPartner = partner;
    refreshActivePage();
}

window.selectPartnerOption = selectPartnerOption;

function registerCurrentPartner() {
    if (!State.currentPartner || !State.currentPartner.serverId) {
        showToast('Select a partner first.', 'error');
        return;
    }
    nuiFetch('registerPartner', { targetSID: Number(State.currentPartner.serverId) });
    showToast('Partner registration request sent.', 'inform');
}

window.registerCurrentPartner = registerCurrentPartner;

function requestPartnerUnregister() {
    let targetSID = State.currentPartner && State.currentPartner.serverId ? Number(State.currentPartner.serverId) : null;
    if (!targetSID) {
        const registeredPartners = getRegisteredPartners();
        if (registeredPartners.length === 1 && registeredPartners[0].serverId) {
            targetSID = Number(registeredPartners[0].serverId);
        }
    }
    if (!targetSID) {
        showToast('Select the partner you want to unregister.', 'error');
        return;
    }
    nuiFetch('requestUnregister', { targetSID });
    showToast('Unregister request sent.', 'inform');
}

window.requestPartnerUnregister = requestPartnerUnregister;

function runDNATest() {
    const target = State.dnaTarget || State.currentPartner;
    if (!target || !target.serverId) {
        showToast('Select a DNA target first.', 'error');
        return;
    }
    nuiFetch('useDNATest', { targetSID: Number(target.serverId) });
}

window.runDNATest = runDNATest;

function renderChildSupportPage() {
    const container = document.getElementById('childsupport-page-content');
    if (!container) return;

    const cases = getChildSupportCases();
    const summary = State.playerData.childSupportSummary || {};
    const cards = cases.length ? cases.map((entry) => `
        <article class="case-card">
            <div class="case-card__body">
                <div class="meta-row">
                    ${buildStatePill(entry.state)}
                    <span class="summary-pill">${esc(formatShortDate(entry.birthTimestamp))}</span>
                </div>
                <h3 class="case-card__title">${esc(entry.childName || entry.childId || 'Baby Profile')}</h3>
                <p class="feed-card__copy">${esc(entry.reason || 'Awaiting eligibility.')}</p>
                <div class="detail-tags">
                    <span class="meta-pill">Mother: ${esc(entry.motherName || 'Unknown')}</span>
                    <span class="meta-pill">Father: ${esc(entry.fatherName || 'Unknown')}</span>
                    <span class="meta-pill">DNA: ${entry.dnaConfirmed ? 'Confirmed' : 'Pending'}</span>
                    <span class="meta-pill">Birth: ${entry.birthConfirmed ? 'Confirmed' : 'Pending'}</span>
                </div>
            </div>
            <div class="case-card__footer">
                <button class="primary-button" type="button" ${entry.eligible ? '' : 'disabled'} onclick="claimChildSupportCase(${Number(entry.id)})">${esc(entry.childSupportClaimed ? 'Claimed' : entry.eligible ? `Claim ${formatCurrency(entry.amount)}` : 'Locked')}</button>
                <span class="summary-pill">${esc(formatCurrency(entry.amount || 0))}</span>
            </div>
        </article>
    `).join('') : renderEmptyState('No child support cases are linked to this tablet yet.');

    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('Child Support', 'Child Support', 'Server-side DNA, birth, role-lock, and one-time payout validation has been restored.')}
            <section class="metrics-strip">
                <article class="metric-tile"><span class="metric-tile__value">${Number(summary.total || 0)}</span><span class="metric-tile__label">Total Cases</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${Number(summary.ready || 0)}</span><span class="metric-tile__label">Ready Claims</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${Number(summary.completed || 0)}</span><span class="metric-tile__label">Completed</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${esc(summary.percent !== undefined ? summary.percent + '%' : '25%')}</span><span class="metric-tile__label">Configured Share</span></article>
            </section>

            <article class="summary-card">
                <div class="panel-card__head">
                    <div><p class="eyebrow">Policy</p><h3 class="summary-card__title">Claim readiness</h3></div>
                    <button class="ghost-button" type="button" onclick="refreshTabletData()">Refresh</button>
                </div>
                <p class="summary-card__copy">A payout is processed only when server-side birth, DNA, role-lock, online, and one-time checks pass.</p>
            </article>

            <section class="case-grid">${cards}</section>
        </div>
    `;
}

window.renderChildSupportPage = renderChildSupportPage;

async function claimChildSupportCase(profileId) {
    await nuiFetch('claimChildSupport', { profileId: Number(profileId) });
}

window.claimChildSupportCase = claimChildSupportCase;

function renderBabyProfilesPage() {
    const container = document.getElementById('babyprofiles-page-content');
    if (!container) return;

    const profiles = getBabyProfiles();
    const cards = profiles.length ? profiles.map((profile) => `
        <article class="profile-card">
            <details>
                <summary>
                    <div>
                        <h3 class="profile-card__title">${esc(profile.childName || profile.childId || 'Baby Profile')}</h3>
                        <div class="feed-meta">Born ${esc(formatShortDate(profile.birthTimestamp))} • ${esc(profile.gender || 'unknown')}</div>
                    </div>
                    ${buildStatePill(profile.dnaConfirmed && profile.childSupportClaimed ? 'completed' : 'ready')}
                </summary>
                <div class="detail-grid" style="margin-top: 14px;">
                    <div class="detail-row"><span>Child ID</span><strong>${esc(profile.childId || 'Unknown')}</strong></div>
                    <div class="detail-row"><span>Birth Timestamp</span><strong>${esc(formatDateTime(profile.birthTimestamp))}</strong></div>
                    <div class="detail-row"><span>Mother</span><strong>${esc(profile.motherName || profile.motherCitizenId || 'Unknown')}</strong></div>
                    <div class="detail-row"><span>Father</span><strong>${esc(profile.fatherName || profile.fatherCitizenId || 'Unknown')}</strong></div>
                    <div class="detail-row"><span>DNA</span><strong>${profile.dnaConfirmed ? 'Confirmed' : 'Pending'}</strong></div>
                    <div class="detail-row"><span>Child Support</span><strong>${profile.childSupportClaimed ? `${formatCurrency(profile.childSupportAmount || 0)} claimed` : 'Not claimed'}</strong></div>
                </div>
            </details>
        </article>
    `).join('') : renderEmptyState('No baby profiles are available yet. Profiles are created when birth is confirmed.');

    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('Baby Profiles', 'Baby Profiles', 'Restored and enhanced child records with DNA, parent links, and payout status.')}
            <section class="metrics-strip">
                <article class="metric-tile"><span class="metric-tile__value">${profiles.length}</span><span class="metric-tile__label">Profiles</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${profiles.filter((profile) => profile.dnaConfirmed).length}</span><span class="metric-tile__label">DNA Confirmed</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${profiles.filter((profile) => profile.childSupportClaimed).length}</span><span class="metric-tile__label">Support Claimed</span></article>
                <article class="metric-tile"><span class="metric-tile__value">${profiles.filter((profile) => !profile.dnaConfirmed).length}</span><span class="metric-tile__label">Waiting On DNA</span></article>
            </section>

            <section class="profile-list">${cards}</section>
        </div>
    `;
}

window.renderBabyProfilesPage = renderBabyProfilesPage;

async function loadPharmacyPage(forceRefresh) {
    if (!Array.isArray(State.pharmacyItems) || !State.pharmacyItems.length || forceRefresh === true) {
        const response = await nuiFetch('getPharmacyItems');
        State.pharmacyItems = Array.isArray(response) ? response : (response && response.items) || [];
    }
    renderPharmacyPage();
}

window.loadPharmacyPage = loadPharmacyPage;

function setPharmacyPayment(payment) {
    State.pharmacyPayment = payment === 'bank' ? 'bank' : 'cash';
    renderPharmacyPage();
}

window.setPharmacyPayment = setPharmacyPayment;

function confirmPharmacyPurchase(itemKey) {
    const entry = (State.pharmacyItems || []).find((item) => item.item === itemKey);
    if (!entry) {
        showToast('That item is no longer available.', 'error');
        return;
    }
    openConfirmModal(`Buy ${entry.label || entry.item}`, `Purchase ${entry.label || entry.item} for ${formatCurrency(entry.price || 0)} using ${State.pharmacyPayment}?`, () => buyPharmacyItem(itemKey));
}

window.confirmPharmacyPurchase = confirmPharmacyPurchase;

async function buyPharmacyItem(itemKey) {
    await nuiFetch('buyPharmacyItem', { item: String(itemKey || ''), payment: State.pharmacyPayment });
}

window.buyPharmacyItem = buyPharmacyItem;

function pharmacyAssetForItem(itemKey) {
    const map = {
        condoms: 'inventory_images/condoms.png',
        contraception: 'inventory_images/contraception.png',
        pregnancy_test: 'inventory_images/pregnancy_test.png',
        prenatal_vitamins: 'inventory_images/prenatal_vitamins.png',
        dna_test: 'inventory_images/dna_test.png',
        std_test_kit: 'inventory_images/std_test_kit.png',
        prescription_meds: 'inventory_images/prescription_meds.png',
        plan_c: 'inventory_images/plan_c.png',
        rhino_pill: 'inventory_images/rhino_pill.png',
        lubricant: 'inventory_images/lubricant.png',
    };
    return map[itemKey] || 'inventory_images/love_tablet.png';
}

function renderPharmacyPage() {
    const container = document.getElementById('pharmacy-page-content');
    if (!container) return;

    const pharmacySettings = getPharmacySettings();
    const items = Array.isArray(State.pharmacyItems) ? State.pharmacyItems : [];
    const cards = pharmacySettings.enabled === false
        ? renderEmptyState('Pharmacy access is disabled in config.')
        : pharmacySettings.allowed === false
            ? renderEmptyState('Pharmacy access is locked for your current role.')
            : items.length ? items.map((item) => `
        <article class="shop-card">
            <div class="shop-card__body">
                <div class="shop-card__footer">
                    <div>
                        <p class="eyebrow">Pharmacy</p>
                        <h3 class="shop-card__title">${esc(item.label || item.item || 'Item')}</h3>
                    </div>
                    <div class="shop-card__media">
                        <img src="${esc(resourceAsset(pharmacyAssetForItem(item.item)))}" alt="${esc(item.label || item.item || 'Item')}" onerror="handleAssetError(this)" />
                        <span class="asset-fallback">RX</span>
                    </div>
                </div>
                <p class="feed-card__copy">${esc(item.desc || 'Medical supply')}</p>
                <div class="shop-card__footer">
                    <span class="shop-card__price">${esc(formatCurrency(item.price || 0))}</span>
                    <span class="summary-pill">${esc(item.amount ? `x${item.amount}` : 'Each')}</span>
                </div>
            </div>
            <div class="shop-card__footer">
                <span class="meta-pill">${esc(State.pharmacyPayment === 'bank' ? 'Bank' : 'Cash')}</span>
                <button class="primary-button" type="button" onclick="confirmPharmacyPurchase('${esc(item.item || '')}')">Buy</button>
            </div>
        </article>
    `).join('') : renderEmptyState('No pharmacy items are configured.');

    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('Pharmacy', 'Pharmacy', 'Restored pharmacy app with stock, payment mode, item art, and working purchase flow.')}
            <article class="summary-card">
                <div class="panel-card__head"><div><p class="eyebrow">Pay With</p><h3 class="summary-card__title">Choose account</h3></div></div>
                <div class="button-row">
                    <button class="toggle-button ${State.pharmacyPayment === 'cash' ? 'active' : ''}" type="button" onclick="setPharmacyPayment('cash')">Cash</button>
                    <button class="toggle-button ${State.pharmacyPayment === 'bank' ? 'active' : ''}" type="button" onclick="setPharmacyPayment('bank')">Bank</button>
                </div>
            </article>
            <section class="shop-grid">${cards}</section>
        </div>
    `;
}

async function ensureCoffeeAccess() {
    if (State.coffee.allowed === null) {
        const response = await nuiFetch('getCoffeeAccess');
        State.coffee.allowed = !!(response && response.allowed);
    }
    return State.coffee.allowed;
}

async function ensureBroCodeAccess() {
    if (State.brocode.allowed === null) {
        const response = await nuiFetch('getBroCodeAccess');
        State.brocode.allowed = !!(response && response.allowed);
    }
    return State.brocode.allowed;
}

async function loadCoffeePage(forceRefresh) {
    const allowed = await ensureCoffeeAccess();
    if (allowed && (!State.coffee.loaded || forceRefresh === true)) {
        const response = await nuiFetch('getCoffeeFeed');
        State.coffee.posts = Array.isArray(response) ? response : (response && response.posts) || [];
        State.coffee.loaded = true;
    }
    renderCoffeePage();
}

window.loadCoffeePage = loadCoffeePage;

async function loadBroCodePage(forceRefresh) {
    const allowed = await ensureBroCodeAccess();
    if (allowed && (!State.brocode.loaded || forceRefresh === true)) {
        const response = await nuiFetch('getBroCodeFeed');
        State.brocode.posts = Array.isArray(response) ? response : (response && response.posts) || [];
        State.brocode.loaded = true;
    }
    renderBroCodePage();
}

window.loadBroCodePage = loadBroCodePage;

function buildFeedMedia(mediaUrl, mediaType) {
    if (!mediaUrl) return '';
    if (mediaType === 'video') {
        return `<div class="feed-media"><video controls preload="metadata" src="${esc(mediaUrl)}"></video></div>`;
    }
    return `<div class="feed-media"><img src="${esc(mediaUrl)}" alt="Feed media" /></div>`;
}

function renderFeedPosts(posts, type) {
    if (!Array.isArray(posts) || !posts.length) return renderEmptyState('No posts yet. Publish the first update.');

    return posts.map((post) => `
        <article class="feed-card">
            <div class="feed-card__body">
                <div class="panel-card__head">
                    <div>
                        <h3 class="feed-card__title">${esc(post.author_name || 'Unknown')}</h3>
                        <div class="feed-meta">${esc(timeSince(post.created_at))}</div>
                    </div>
                    <span class="summary-pill">Post #${Number(post.id)}</span>
                </div>
                <p class="feed-card__copy">${esc(post.body || '')}</p>
                ${buildFeedMedia(post.media_url, post.media_type)}
                ${(post.comments || []).length ? `
                    <div class="feed-comment-list">
                        ${(post.comments || []).map((comment) => `
                            <div class="feed-comment">
                                <div class="comment-author">${esc(comment.author_name || 'Unknown')}</div>
                                <div class="feed-meta">${esc(comment.body || '')}</div>
                            </div>
                        `).join('')}
                    </div>
                ` : ''}
            </div>
            <div class="feed-card__footer">
                <input id="${esc(type)}-comment-${Number(post.id)}" class="text-field" type="text" maxlength="250" placeholder="Add a comment" />
                <button class="ghost-button" type="button" onclick="${type === 'coffee' ? 'submitCoffeeComment' : 'submitBroCodeComment'}(${Number(post.id)})">Reply</button>
            </div>
        </article>
    `).join('');
}

function renderCoffeePage() {
    const container = document.getElementById('coffee-page-content');
    if (!container) return;

    const allowed = State.coffee.allowed !== false;
    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('Coffee', 'Coffee', 'Restored Coffee app with posting, comments, and ped-gated social access.')}
            <article class="summary-card">
                <div class="panel-card__head">
                    <div><p class="eyebrow">Access</p><h3 class="summary-card__title">Coffee feed</h3></div>
                    <button class="ghost-button" type="button" onclick="loadCoffeePage(true)">Refresh</button>
                </div>
                <p class="summary-card__copy">${esc(allowed ? 'Coffee is unlocked for this current ped setup.' : 'Coffee is locked for this current ped setup.')}</p>
            </article>

            ${allowed ? `
                <article class="summary-card">
                    <div class="panel-card__head"><div><p class="eyebrow">Post</p><h3 class="summary-card__title">Share an update</h3></div></div>
                    <textarea id="coffee-body" class="text-field text-field--tall" maxlength="400" placeholder="Drop a Coffee update..."></textarea>
                    <div class="card-grid">
                        <input id="coffee-media-url" class="text-field" type="text" maxlength="512" placeholder="Optional media URL" />
                        <select id="coffee-media-type" class="select-field"><option value="none">No media</option><option value="image">Image</option><option value="video">Video</option></select>
                    </div>
                    <div class="button-row button-row--end"><button class="primary-button" type="button" onclick="submitCoffeePost()">Publish Post</button></div>
                </article>
            ` : ''}

            <section class="profile-list">${allowed ? renderFeedPosts(State.coffee.posts, 'coffee') : renderEmptyState('Coffee is not available for this character.')}</section>
        </div>
    `;
}

function renderBroCodePage() {
    const container = document.getElementById('brocode-page-content');
    if (!container) return;

    const allowed = State.brocode.allowed !== false;
    container.innerHTML = `
        <div class="page-shell">
            ${pageHeader('Bro Code', 'Bro Code', 'Restored Bro Code feed, posting tools, and ped-gated access checks.')}
            <article class="summary-card">
                <div class="panel-card__head">
                    <div><p class="eyebrow">Access</p><h3 class="summary-card__title">Bro Code feed</h3></div>
                    <button class="ghost-button" type="button" onclick="loadBroCodePage(true)">Refresh</button>
                </div>
                <p class="summary-card__copy">${esc(allowed ? 'Bro Code is unlocked for this current ped setup.' : 'Bro Code is locked for this current ped setup.')}</p>
            </article>

            ${allowed ? `
                <article class="summary-card">
                    <div class="panel-card__head"><div><p class="eyebrow">Post</p><h3 class="summary-card__title">Share an update</h3></div></div>
                    <textarea id="brocode-body" class="text-field text-field--tall" maxlength="400" placeholder="Drop a Bro Code update..."></textarea>
                    <div class="card-grid">
                        <input id="brocode-media-url" class="text-field" type="text" maxlength="512" placeholder="Optional media URL" />
                        <select id="brocode-media-type" class="select-field"><option value="none">No media</option><option value="image">Image</option><option value="video">Video</option></select>
                    </div>
                    <div class="button-row button-row--end"><button class="primary-button" type="button" onclick="submitBroCodePost()">Publish Post</button></div>
                </article>
            ` : ''}

            <section class="profile-list">${allowed ? renderFeedPosts(State.brocode.posts, 'brocode') : renderEmptyState('Bro Code is not available for this character.')}</section>
        </div>
    `;
}

async function submitCoffeePost() {
    if (State.coffee.allowed === false) {
        showToast('Coffee is locked.', 'error');
        return;
    }
    const payload = {
        body: document.getElementById('coffee-body')?.value || '',
        mediaUrl: document.getElementById('coffee-media-url')?.value || '',
        mediaType: document.getElementById('coffee-media-type')?.value || 'none',
    };
    const response = await nuiFetch('createCoffeePost', payload);
    if (!response || response.ok === false) {
        showToast((response && response.error) || 'Unable to publish post.', 'error');
        return;
    }
    State.coffee.posts = response.posts || [];
    State.coffee.loaded = true;
    renderCoffeePage();
    showToast('Coffee post published.', 'success');
}

window.submitCoffeePost = submitCoffeePost;

async function submitCoffeeComment(postId) {
    const input = document.getElementById(`coffee-comment-${Number(postId)}`);
    const response = await nuiFetch('createCoffeeComment', { postId: Number(postId), body: input?.value || '' });
    if (!response || response.ok === false) {
        showToast((response && response.error) || 'Unable to publish comment.', 'error');
        return;
    }
    State.coffee.posts = response.posts || [];
    State.coffee.loaded = true;
    if (input) input.value = '';
    renderCoffeePage();
    showToast('Comment added.', 'success');
}

window.submitCoffeeComment = submitCoffeeComment;

async function submitBroCodePost() {
    if (State.brocode.allowed === false) {
        showToast('Bro Code is locked.', 'error');
        return;
    }
    const payload = {
        body: document.getElementById('brocode-body')?.value || '',
        mediaUrl: document.getElementById('brocode-media-url')?.value || '',
        mediaType: document.getElementById('brocode-media-type')?.value || 'none',
    };
    const response = await nuiFetch('createBroCodePost', payload);
    if (!response || response.ok === false) {
        showToast((response && response.error) || 'Unable to publish post.', 'error');
        return;
    }
    State.brocode.posts = response.posts || [];
    State.brocode.loaded = true;
    renderBroCodePage();
    showToast('Bro Code post published.', 'success');
}

window.submitBroCodePost = submitBroCodePost;

async function submitBroCodeComment(postId) {
    const input = document.getElementById(`brocode-comment-${Number(postId)}`);
    const response = await nuiFetch('createBroCodeComment', { postId: Number(postId), body: input?.value || '' });
    if (!response || response.ok === false) {
        showToast((response && response.error) || 'Unable to publish comment.', 'error');
        return;
    }
    State.brocode.posts = response.posts || [];
    State.brocode.loaded = true;
    if (input) input.value = '';
    renderBroCodePage();
    showToast('Comment added.', 'success');
}

window.submitBroCodeComment = submitBroCodeComment;

