let isCreatorOpen = false;
let isBenchOpen = false;
let isBenchAnimating = false;
let currentBench = null;
let benchesData = [];
let benchTypes = {};
let accessTypes = {};
let propModels = {};
let playerCoords = { x: 0, y: 0, z: 0 };
let playerXP = { xp: 0, level: 1 };
let locale = {};
function t(key, fallback) {
    return locale[key] || fallback || key;
}
let currentPage = 'dashboard';
let currentRecipes = [];
let deleteTarget = null;
let deleteCallback = null;
let currentAccessData = {
    groups: [],
    jobs: [],
    gangs: [],
    roles: [],
    ownerId: null
};
let oxInventoryConfig = null;
let customItemImagePath = null;
let globalSettings = null;
let recipeGroups = [];
let currentEditingGroup = null;
let currentGroupRecipes = [];
let benchRecipeSearch = '';
let groupRecipeSearch = '';
let selectedRecipeGroupIds = [];
let allInventoryItems = {};
let allInventoryItemsList = [];

const domCache = {};
function getElement(id) {
    if (!domCache[id]) {
        domCache[id] = document.getElementById(id);
    }
    return domCache[id];
}
function clearDomCache() {
    for (const key in domCache) {
        delete domCache[key];
    }
}

function showModal(modal) {
    modal.classList.remove('hidden');
}

function hideModal(modal, callback) {
    modal.classList.add('hidden');
    if (callback) callback();
}

function showAlert(message) {
    const modal = document.getElementById('custom-alert-modal');
    const msg = document.getElementById('custom-alert-message');
    if (!modal || !msg) return;
    msg.textContent = message;
    modal.classList.remove('hidden');
    lucide.createIcons();
}

function closeAlert() {
    const modal = document.getElementById('custom-alert-modal');
    if (modal) modal.classList.add('hidden');
}

function debounce(func, wait) {
    let timeout;
    return function(...args) {
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(this, args), wait);
    };
}

function getItemImagePath(itemName) {
    if (customItemImagePath) {
        return customItemImagePath + itemName + '.png';
    }
    if (oxInventoryConfig && oxInventoryConfig.imagePath) {
        return oxInventoryConfig.imagePath + itemName + '.png';
    }
    return 'nui://ox_inventory/web/images/' + itemName + '.png';
}
document.addEventListener('DOMContentLoaded', function() {
    lucide.createIcons();
    initializeEventListeners();
    fetch(`https://${getResourceName()}/uiReady`, { method: 'POST', body: JSON.stringify({}) });
});
function getResourceName() {
    return window.GetParentResourceName ? window.GetParentResourceName() : 'FearX-Crafting';
}
function sendToLua(action, payload) {
    fetch(`https://${getResourceName()}/${action}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload || {})
    }).catch(() => {});
}
window.addEventListener('message', function(e) {
    const data = e.data;
    if (!data || typeof data.action !== 'string') return;

    switch(data.action) {
        case 'openCreator':
            openCreator(data);
            break;
        case 'closeCreator':
            closeCreator();
            break;
        case 'openBench':
            openBench(data);
            break;
        case 'closeBench':
            closeBench();
            break;
        case 'hideBenchForCrafting':
            hideBenchForCrafting();
            break;
        case 'updateCoords':
            playerCoords = data.coords;
            break;
        case 'updateXP':
            playerXP.xp = data.xp;
            playerXP.level = data.level;
            updateXPDisplay();
            break;
        case 'startCrafting':
            startCraftingAnimation(data);
            break;
        case 'craftRejected':
            craftRejected(data);
            break;
        case 'craftSuccess':
            craftComplete(true, data);
            break;
        case 'craftFailed':
            craftComplete(false, data);
            break;
        case 'craftCancelled':
            hideCraftingOverlay();
            break;
        case 'showSimpleSkillCheck':
            showSimpleSkillCheck(data);
            break;
        case 'updateSkillCheck':
            updateSkillCheck(data.position);
            break;
        case 'hideSkillCheck':
            hideSkillCheck(data.success);
            break;
        case 'hidePropPlacer':
            document.getElementById('creator-app').style.opacity = '0';
            document.getElementById('creator-app').style.pointerEvents = 'none';
            break;
        case 'propPlacerComplete':
            handlePropPlacerComplete(data);
            break;
        case 'receivePlayerInfo':
            displayOwnerInfo(data);
            break;
    }
});
function translateStaticElements() {
    const translations = {
        'bench-modal-title': t('createBench', 'Create Bench'),
        'recipe-modal-title': t('addRecipe', 'Add Recipe'),
        'group-modal-title': t('createRecipeGroup', 'Create Recipe Group'),
        'group-recipe-modal-title': t('addRecipe', 'Add Recipe'),
    };
    for (const [id, text] of Object.entries(translations)) {
        const el = document.getElementById(id);
        if (el) el.textContent = text;
    }
    const benchCloseBtn = document.querySelector('.bench-close-btn');
    if (benchCloseBtn) benchCloseBtn.textContent = t('close', 'CLOSE').toUpperCase();
    const benchSearchInput = document.getElementById('bench-search-input');
    if (benchSearchInput) benchSearchInput.placeholder = t('searchRecipes', 'Search available recipes...');
    const benchContentTitle = document.querySelector('.bench-content-title');
    if (benchContentTitle) benchContentTitle.textContent = t('availableRecipes', 'Available Recipes');
    const benchContentSubtitle = document.querySelector('.bench-content-subtitle');
    if (benchContentSubtitle) benchContentSubtitle.textContent = t('selectItemToCraft', 'Select an item to begin crafting');
    const modalTabs = document.querySelectorAll('.modal-tab');
    const tabLabels = {
        'basic': t('basicInfo', 'Basic Info'),
        'access': t('access', 'Access'),
        'recipes': t('recipes', 'Recipes'),
        'settings': t('settings', 'Settings')
    };
    modalTabs.forEach(tab => {
        const tabId = tab.getAttribute('data-modal-tab');
        if (tabId && tabLabels[tabId]) {
            tab.textContent = tabLabels[tabId];
        }
    });
    const benchModalCancel = document.getElementById('bench-modal-cancel');
    if (benchModalCancel) benchModalCancel.textContent = t('cancel', 'Cancel');
    const benchModalSave = document.getElementById('bench-modal-save');
    if (benchModalSave) benchModalSave.textContent = t('save', 'Save');
    const recipeModalCancel = document.getElementById('recipe-modal-cancel');
    if (recipeModalCancel) recipeModalCancel.textContent = t('cancel', 'Cancel');
    const recipeModalSave = document.getElementById('recipe-modal-save');
    if (recipeModalSave) recipeModalSave.textContent = t('save', 'Save');
    const deleteCancel = document.getElementById('delete-cancel');
    if (deleteCancel) deleteCancel.textContent = t('cancel', 'Cancel');
    const deleteConfirm = document.getElementById('delete-confirm');
    if (deleteConfirm) deleteConfirm.textContent = t('delete', 'Delete');
    const confirmDeleteTitle = document.querySelector('#delete-modal h3');
    if (confirmDeleteTitle) confirmDeleteTitle.textContent = t('confirmDelete', 'Confirm Delete');
    const benchTitleText = document.getElementById('bench-title-text');
    if (benchTitleText) benchTitleText.textContent = t('craftingTable', 'Crafting Table');
    const benchPlayerLevel = document.getElementById('bench-player-level');
    if (benchPlayerLevel) benchPlayerLevel.textContent = t('yourLevel', 'Your Level') + ': ' + (playerXP?.level || 1);
    document.querySelectorAll('#modal-tab-basic label').forEach(label => {
        const text = label.textContent.trim();
        if (text === 'Bench Name') label.textContent = t('benchName', 'Bench Name');
        else if (text === 'Type') label.textContent = t('type', 'Type');
        else if (text === 'Prop Model') label.textContent = t('propModel', 'Prop Model');
        else if (text === 'Coordinates') label.textContent = t('coordinates', 'Coordinates');
        else if (text.startsWith('Heading')) label.innerHTML = t('heading', 'Heading') + ': <span id="heading-value">' + (document.getElementById('heading-value')?.textContent || '0') + '</span>°';
        else if (text === 'Show on Map') label.textContent = t('showOnMap', 'Show on Map');
    });
    document.querySelectorAll('#modal-tab-access label').forEach(label => {
        const text = label.textContent.trim();
        if (text === 'Access Type') label.textContent = t('accessType', 'Access Type');
        else if (text === 'Allowed Groups') label.textContent = t('allowedGroups', 'Allowed Groups');
        else if (text === 'Allowed Jobs') label.textContent = t('allowedJobs', 'Allowed Jobs');
        else if (text === 'Allowed Gangs') label.textContent = t('allowedGangs', 'Allowed Gangs');
        else if (text === 'Discord Role IDs' || text === 'Discord Role / User IDs') label.textContent = t('discordRoleIds', 'Discord Role / User IDs');
        else if (text === 'Player Server ID') label.textContent = t('playerServerId', 'Player Server ID');
        else if (text === 'Player Name') label.textContent = t('playerName', 'Player Name');
        else if (text === 'License') label.textContent = t('license', 'License');
    });
    const addJobBtn = document.getElementById('add-job-btn');
    if (addJobBtn) addJobBtn.innerHTML = '<i data-lucide="plus" class="w-3 h-3"></i> ' + t('addJob', 'Add Job');
    const addGangBtn = document.getElementById('add-gang-btn');
    if (addGangBtn) addGangBtn.innerHTML = '<i data-lucide="plus" class="w-3 h-3"></i> ' + t('addGang', 'Add Gang');
    const addIngredientBtn = document.getElementById('add-ingredient-btn');
    if (addIngredientBtn) addIngredientBtn.innerHTML = '<i data-lucide="plus" class="w-3 h-3"></i> ' + t('addIngredient', 'Add Ingredient');
    const grabInfoBtn = document.getElementById('grab-player-info-btn');
    if (grabInfoBtn) grabInfoBtn.innerHTML = '<i data-lucide="search" class="w-4 h-4"></i> ' + t('grabInfo', 'Grab Info');
    document.querySelectorAll('#modal-tab-recipes h4').forEach(h4 => {
        if (h4.textContent.trim() === 'Recipe Groups') h4.textContent = t('recipeGroups', 'Recipe Groups');
    });
    document.querySelectorAll('#modal-tab-settings h4').forEach(h4 => {
        if (h4.textContent.trim() === 'Crafting Options') h4.textContent = t('craftingOptions', 'Crafting Options');
    });
    document.querySelectorAll('#modal-tab-settings .text-white.text-sm.font-medium').forEach(span => {
        const text = span.textContent.trim();
        if (text === 'Skill Check Override') span.textContent = t('skillCheckOverride', 'Skill Check Override');
        else if (text === 'XP Override') span.textContent = t('xpOverride', 'XP Override');
    });
    document.querySelectorAll('#modal-tab-settings .text-gray-500.text-xs').forEach(p => {
        const text = p.textContent.trim();
        if (text === 'Override global skill check setting') p.textContent = t('skillCheckOverrideDesc', 'Override global skill check setting');
        else if (text === 'Override global XP setting') p.textContent = t('xpOverrideDesc', 'Override global XP setting');
    });
    lucide.createIcons();
}
function openCreator(data) {
    isCreatorOpen = true;
    benchesData = data.benches || [];
    benchTypes = data.benchTypes || {};
    accessTypes = data.accessTypes || {};
    propModels = data.propModels || {};
    recipeGroups = data.recipeGroups || [];
    playerCoords = data.coords || { x: 0, y: 0, z: 0 };
    locale = data.locale || {};
    globalSettings = data.settings || null;
    if (data.itemImagePath) {
        customItemImagePath = data.itemImagePath;
    }
    if (data.allItems) {
        allInventoryItems = data.allItems;
        allInventoryItemsList = Object.values(data.allItems).sort((a, b) => (a.label || '').localeCompare(b.label || ''));
    }
    translateStaticElements();
    const creatorApp = getElement('creator-app');
    creatorApp.classList.remove('hidden');
    currentPage = 'dashboard';
    renderCreatorSidebar();
    renderCreatorPage();
    lucide.createIcons();
}
function closeCreator() {
    isCreatorOpen = false;
    const creatorApp = getElement('creator-app');
    creatorApp.classList.add('hidden');
    sendToLua('closeCreator', {});
}
function renderCreatorSidebar() {
    const nav = document.getElementById('creator-sidebar-nav');
    const pages = [
        { id: 'dashboard', label: t('dashboard', 'Dashboard'), icon: 'layout-dashboard' },
        { id: 'benches', label: t('benches', 'Benches'), icon: 'hammer' },
        { id: 'recipegroups', label: t('recipeGroups', 'Recipe Groups'), icon: 'folder' },
        { id: 'settings', label: t('settings', 'Settings'), icon: 'settings' }
    ];
    nav.innerHTML = pages.map(page => {
        const isActive = currentPage === page.id;
        return `
            <button onclick="switchCreatorPage('${page.id}')" class="w-full flex items-center gap-3 px-4 py-2.5 text-xs font-semibold rounded-lg transition-all relative group mb-1 ${isActive ? 'text-white' : 'text-gray-500 hover:text-gray-300'}">
                ${isActive ? '<div class="absolute left-0 top-1.5 bottom-1.5 w-[3px] bg-white rounded-full shadow-[0_0_12px_rgba(255,255,255,0.8)]"></div><div class="absolute inset-0 bg-gradient-to-r from-white/10 to-transparent rounded-lg pointer-events-none"></div>' : ''}
                <i data-lucide="${page.icon}" class="w-4 h-4 relative z-10"></i>
                <span class="relative z-10 tracking-wide">${page.label}</span>
            </button>
        `;
    }).join('');
    lucide.createIcons();
}
function switchCreatorPage(page) {
    currentPage = page;
    renderCreatorSidebar();
    renderCreatorPage();
}
function renderCreatorPage() {
    const contentArea = document.getElementById('creator-content-area');
    switch(currentPage) {
        case 'dashboard':
            contentArea.innerHTML = renderCreatorDashboard();
            break;
        case 'benches':
            contentArea.innerHTML = renderBenchesList();
            attachBenchListeners();
            break;
        case 'recipegroups':
            contentArea.innerHTML = renderRecipeGroupsPage();
            attachRecipeGroupListeners();
            break;
        case 'settings':
            contentArea.innerHTML = renderCreatorSettings();
            initSettingsListeners();
            break;
    }
    lucide.createIcons();
}
const icons = {
    hammer: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m15 12-8.5 8.5c-.83.83-2.17.83-3 0 0 0 0 0 0 0a2.12 2.12 0 0 1 0-3L12 9"/><path d="M17.64 15 22 10.64"/><path d="m20.91 11.7-1.25-1.25c-.6-.6-.93-1.4-.93-2.25v-.86L16.01 4.6a5.56 5.56 0 0 0-3.94-1.64H9l.92.82A6.18 6.18 0 0 1 12 8.4v1.56l2 2h2.47l2.26 1.91"/></svg>',
    package: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16.5 9.4 7.55 4.24"/><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/><polyline points="3.29 7 12 12 20.71 7"/><line x1="12" x2="12" y1="22" y2="12"/></svg>',
    wrench: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg>',
    crosshair: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="22" x2="18" y1="12" y2="12"/><line x1="6" x2="2" y1="12" y2="12"/><line x1="12" x2="12" y1="6" y2="2"/><line x1="12" x2="12" y1="22" y2="18"/></svg>',
    plus: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" x2="12" y1="5" y2="19"/><line x1="5" x2="19" y1="12" y2="12"/></svg>',
    alertTriangle: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><line x1="12" x2="12" y1="9" y2="13"/><line x1="12" x2="12.01" y1="17" y2="17"/></svg>',
    edit: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/><path d="m15 5 4 4"/></svg>',
    trash: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/></svg>',
    mapPin: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="3"/></svg>',
    search: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" x2="16.65" y1="21" y2="16.65"/></svg>',
    chevronDown: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m6 9 6 6 6-6"/></svg>',
    x: '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>'
};
function getIcon(name, className = '') {
    return icons[name] ? icons[name].replace('width="16"', `width="16" class="${className}"`) : '';
}
function renderCreatorDashboard() {
    const totalRecipes = benchesData.reduce((acc, b) => acc + (b.recipes?.length || 0), 0);
    return `
        <header class="px-8 py-8 flex justify-between items-start z-10 animate-fade-in">
            <div class="flex items-center gap-4">
                <h2 class="text-white text-3xl font-bold tracking-tight">${t('dashboard', 'Dashboard')}</h2>
                <div class="px-3 py-1 rounded-full border border-white/10 bg-white/5 text-gray-400 text-[10px] font-bold uppercase tracking-wider">${t('adminOverview', 'Admin Overview')}</div>
            </div>
            <button onclick="closeCreator()" class="bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-wider transition-all">${t('close', 'Close')}</button>
        </header>
        <div class="flex-1 overflow-y-auto px-8 pb-8 z-10 scrollbar-hide flex flex-col gap-5 animate-fade-in">
            <div class="grid grid-cols-3 gap-5">
                <div class="bg-[#121212]/50 rounded-xl p-6 border border-white/[0.04] relative overflow-hidden group">
                    <div class="absolute top-0 right-0 w-32 h-32 bg-white/5 blur-[50px] rounded-full pointer-events-none"></div>
                    <div class="flex justify-between items-start mb-4">
                        <h3 class="text-white font-bold text-base">${t('totalBenches', 'Total Benches')}</h3>
                        <div class="w-8 h-8 bg-white rounded-lg flex items-center justify-center text-black shadow-[0_0_15px_rgba(255,255,255,0.2)]">
                            <i data-lucide="hammer" class="w-4 h-4"></i>
                        </div>
                    </div>
                    <div class="text-4xl font-bold text-white tracking-tight">${benchesData.length}</div>
                    <div class="text-gray-600 text-[10px] mt-2">${t('registeredWorkstations', 'Registered workstations')}</div>
                </div>
                <div class="bg-[#121212]/50 rounded-xl p-6 border border-white/[0.04] relative overflow-hidden group">
                    <div class="absolute top-0 right-0 w-32 h-32 bg-white/5 blur-[50px] rounded-full pointer-events-none"></div>
                    <div class="flex justify-between items-start mb-4">
                        <h3 class="text-white font-bold text-base">${t('totalRecipes', 'Total Recipes')}</h3>
                        <div class="w-8 h-8 bg-white rounded-lg flex items-center justify-center text-black shadow-[0_0_15px_rgba(255,255,255,0.2)]">
                            <i data-lucide="package" class="w-4 h-4"></i>
                        </div>
                    </div>
                    <div class="text-4xl font-bold text-white tracking-tight">${totalRecipes}</div>
                    <div class="text-gray-600 text-[10px] mt-2">${t('craftableItems', 'Craftable items')}</div>
                </div>
                <div class="bg-[#121212]/50 rounded-xl p-6 border border-white/[0.04] relative overflow-hidden group">
                    <div class="absolute top-0 right-0 w-32 h-32 bg-white/5 blur-[50px] rounded-full pointer-events-none"></div>
                    <div class="flex justify-between items-start mb-4">
                        <h3 class="text-white font-bold text-base">${t('recipeGroups', 'Recipe Groups')}</h3>
                        <div class="w-8 h-8 bg-white rounded-lg flex items-center justify-center text-black shadow-[0_0_15px_rgba(255,255,255,0.2)]">
                            <i data-lucide="layers" class="w-4 h-4"></i>
                        </div>
                    </div>
                    <div class="text-4xl font-bold text-white tracking-tight">${recipeGroups.length}</div>
                    <div class="text-gray-600 text-[10px] mt-2">${t('sharedRecipeTemplates', 'Shared recipe templates')}</div>
                </div>
            </div>
            <div class="bg-[#121212]/50 rounded-xl p-6 border border-white/[0.04] relative overflow-hidden">
                <div class="absolute top-0 right-0 w-32 h-32 bg-white/5 blur-[50px] rounded-full pointer-events-none"></div>
                <div class="flex justify-between items-start mb-4">
                    <h3 class="text-white font-bold text-base">${t('yourPosition', 'Your Position')}</h3>
                    <div class="w-8 h-8 bg-white rounded-lg flex items-center justify-center text-black shadow-[0_0_15px_rgba(255,255,255,0.2)]">
                        <i data-lucide="crosshair" class="w-4 h-4"></i>
                    </div>
                </div>
                <div class="text-sm font-mono text-white tracking-tight">${playerCoords.x.toFixed(2)}, ${playerCoords.y.toFixed(2)}, ${playerCoords.z.toFixed(2)}</div>
                <div class="text-gray-600 text-[10px] mt-2">${t('currentCoordinates', 'Current coordinates')}</div>
            </div>
            <div class="bg-[#121212]/50 rounded-xl p-6 border border-white/[0.04]">
                <h3 class="text-white font-bold text-base mb-4">${t('quickActions', 'Quick Actions')}</h3>
                <div class="flex gap-3">
                    <button onclick="openBenchModal()" class="bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-6 py-3 rounded-lg text-sm font-bold transition-all uppercase tracking-wide flex items-center gap-2">
                        <i data-lucide="plus" class="w-4 h-4"></i> ${t('createBench', 'Create Bench')}
                    </button>
                </div>
            </div>
        </div>
    `;
}
function renderBenchesList() {
    return `
        <header class="px-8 py-8 flex justify-between items-start z-10 animate-fade-in">
            <div class="flex items-center gap-4">
                <h2 class="text-white text-3xl font-bold tracking-tight">${t('benches', 'Benches')}</h2>
                <div class="px-3 py-1 rounded-full border border-white/10 bg-white/5 text-gray-400 text-[10px] font-bold uppercase tracking-wider">${benchesData.length} ${t('total', 'Total')}</div>
            </div>
            <div class="flex gap-3">
                <button onclick="openBenchModal()" class="bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-wider transition-all flex items-center gap-2">
                    <i data-lucide="plus" class="w-4 h-4"></i> ${t('create', 'Create')}
                </button>
                <button onclick="closeCreator()" class="bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-wider transition-all">${t('close', 'Close')}</button>
            </div>
        </header>
        <div class="flex-1 overflow-y-auto px-8 pb-8 z-10 scrollbar-hide animate-fade-in">
            <div class="bg-amber-500/10 border border-amber-500/30 rounded-lg p-3 mb-4 flex items-center gap-2">
                <i data-lucide="alert-triangle" class="w-5 h-5 text-amber-500 shrink-0"></i>
                <p class="text-amber-200 text-xs">${t('restartWarning', 'You must restart the script for new or edited benches to fully register.')}</p>
            </div>
            <div id="benches-list" class="space-y-2">
                ${benchesData.length === 0 ? '<div class="text-gray-500 text-center py-20">' + t('noBenchesYet', 'No benches created yet') + '</div>' : benchesData.map(bench => {
                    const typeInfo = benchTypes[bench.type] || { label: bench.type, icon: 'hammer' };
                    const recipeCount = (bench.recipes || []).length;
                    const iconName = typeInfo.icon || 'hammer';
                    return `
                        <div class="bg-[#1a1a1a]/40 hover:bg-[#1a1a1a] border border-white/5 rounded-lg p-4 flex items-center justify-between transition-colors" data-bench-id="${bench.id}">
                            <div class="flex items-center gap-4">
                                <div class="w-10 h-10 rounded-lg bg-white/10 flex items-center justify-center border border-white/10">
                                    <i data-lucide="${iconName}" class="w-5 h-5 text-white"></i>
                                </div>
                                <div>
                                    <h4 class="text-white font-bold text-sm">${bench.name}</h4>
                                    <p class="text-gray-500 text-xs">${typeInfo.label} • ${recipeCount} recipes • ${accessTypes[bench.accessType]?.label || bench.accessType}</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-2">
                                <button class="teleport-btn bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2 rounded-md text-xs font-bold transition-all" data-id="${bench.id}">TP</button>
                                <button class="edit-btn bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2 rounded-md text-xs font-bold transition-all" data-id="${bench.id}">${t('edit', 'Edit')}</button>
                                <button class="delete-btn bg-white/5 border border-white/10 text-red-400 hover:text-red-300 hover:bg-white/10 px-4 py-2 rounded-md text-xs font-bold transition-all" data-id="${bench.id}">${t('delete', 'Delete')}</button>
                            </div>
                        </div>
                    `;
                }).join('')}
            </div>
        </div>
    `;
}
function renderRecipeGroupsPage() {
    const filteredGroups = recipeGroups.filter(g =>
        !groupRecipeSearch || g.name.toLowerCase().includes(groupRecipeSearch.toLowerCase())
    );
    return `
        <header class="px-8 py-8 flex justify-between items-start z-10 animate-fade-in">
            <div class="flex items-center gap-4">
                <h2 class="text-white text-3xl font-bold tracking-tight">${t('recipeGroups', 'Recipe Groups')}</h2>
                <div class="px-3 py-1 rounded-full border border-white/10 bg-white/5 text-gray-400 text-[10px] font-bold uppercase tracking-wider">${recipeGroups.length} ${t('groups', 'Groups')}</div>
            </div>
            <div class="flex gap-3">
                <button onclick="openGroupModal()" class="bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-wider transition-all flex items-center gap-2">
                    <i data-lucide="plus" class="w-4 h-4"></i> ${t('createGroup', 'Create Group')}
                </button>
                <button onclick="closeCreator()" class="bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-wider transition-all">${t('close', 'Close')}</button>
            </div>
        </header>
        <div class="flex-1 overflow-y-auto px-8 pb-8 z-10 scrollbar-hide animate-fade-in">
            <div class="mb-4">
                <div class="relative">
                    <i data-lucide="search" class="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-500"></i>
                    <input type="text" id="group-search-input" placeholder="${t('searchGroups', 'Search groups...')}" value="${groupRecipeSearch}" class="w-full bg-[#1a1a1a] border border-white/10 rounded-lg pl-11 pr-4 py-3 text-white text-sm focus:outline-none focus:border-white/30 transition-colors">
                </div>
            </div>
            <div id="groups-list" class="space-y-2">
                ${filteredGroups.length === 0 ? '<div class="text-gray-500 text-center py-20">' + t('noGroupsYet', 'No recipe groups created yet') + '</div>' : filteredGroups.map(group => {
                    const recipeCount = (group.recipes || []).length;
                    return `
                        <div class="bg-[#1a1a1a]/40 hover:bg-[#1a1a1a] border border-white/5 rounded-lg p-4 flex items-center justify-between transition-colors" data-group-id="${group.id}">
                            <div class="flex items-center gap-4">
                                <div class="w-10 h-10 rounded-lg bg-white/10 flex items-center justify-center border border-white/10">
                                    <i data-lucide="folder" class="w-5 h-5 text-white"></i>
                                </div>
                                <div>
                                    <h4 class="text-white font-bold text-sm">${group.name}</h4>
                                    <p class="text-gray-500 text-xs">${recipeCount} ${t('recipes', 'recipes')}</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-2">
                                <button class="edit-group-btn bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2 rounded-md text-xs font-bold transition-all" data-id="${group.id}">${t('edit', 'Edit')}</button>
                                <button class="delete-group-btn bg-white/5 border border-white/10 text-red-400 hover:text-red-300 hover:bg-white/10 px-4 py-2 rounded-md text-xs font-bold transition-all" data-id="${group.id}">${t('delete', 'Delete')}</button>
                            </div>
                        </div>
                    `;
                }).join('')}
            </div>
        </div>
    `;
}
function attachRecipeGroupListeners() {
    document.getElementById('group-search-input')?.addEventListener('input', (e) => {
        groupRecipeSearch = e.target.value;
        renderCreatorPage();
    });
    document.querySelectorAll('.edit-group-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const groupId = btn.dataset.id;
            const group = recipeGroups.find(g => g.id === groupId);
            if (group) openGroupModal(group);
        });
    });
    document.querySelectorAll('.delete-group-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const groupId = btn.dataset.id;
            showDeleteModal(t('confirmDeleteGroup', 'Are you sure you want to delete this recipe group?'), () => {
                recipeGroups = recipeGroups.filter(g => g.id !== groupId);
                saveRecipeGroups();
                renderCreatorPage();
            });
        });
    });
}
function openGroupModal(group = null) {
    currentEditingGroup = group;
    currentGroupRecipes = group ? [...(group.recipes || [])] : [];
    const modal = getElement('group-modal');
    const title = getElement('group-modal-title');
    if (group) {
        title.textContent = t('editRecipeGroup', 'Edit Recipe Group');
        getElement('group-input-name').value = group.name;
    } else {
        title.textContent = t('createRecipeGroup', 'Create Recipe Group');
        getElement('group-input-name').value = '';
    }
    renderGroupRecipesEditor();
    showModal(modal);
    lucide.createIcons();
}
function closeGroupModal() {
    const modal = getElement('group-modal');
    hideModal(modal, () => {
        currentEditingGroup = null;
        currentGroupRecipes = [];
    });
}
function saveGroup() {
    const name = document.getElementById('group-input-name').value.trim();
    if (!name) {
        showAlert(t('enterGroupName', 'Please enter a group name'));
        return;
    }
    if (currentEditingGroup) {
        const index = recipeGroups.findIndex(g => g.id === currentEditingGroup.id);
        if (index !== -1) {
            recipeGroups[index] = {
                ...recipeGroups[index],
                name: name,
                recipes: currentGroupRecipes
            };
        }
    } else {
        recipeGroups.push({
            id: 'group_' + Date.now(),
            name: name,
            recipes: currentGroupRecipes
        });
    }
    saveRecipeGroups();
    closeGroupModal();
    renderCreatorPage();
}
function renderGroupRecipesEditor() {
    const container = document.getElementById('group-recipes-list');
    if (!container) return;
    container.innerHTML = currentGroupRecipes.length === 0 ?
        '<div class="text-gray-500 text-center py-10 text-sm">' + t('noRecipesInGroup', 'No recipes in this group') + '</div>' :
        currentGroupRecipes.map((recipe, index) => `
            <div class="bg-[#1a1a1a] border border-white/10 rounded-lg p-3 flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <div class="w-8 h-8 bg-white/10 rounded-md flex items-center justify-center">
                        <i data-lucide="book-open" class="w-4 h-4 text-white"></i>
                    </div>
                    <div>
                        <div class="text-white font-medium text-sm">${recipe.label || recipe.name}</div>
                        <div class="text-gray-500 text-xs">${(recipe.ingredients || []).length} ${t('ingredients', 'ingredients')}</div>
                    </div>
                </div>
                <div class="flex gap-2">
                    <button onclick="editGroupRecipe(${index})" class="bg-white/5 border border-white/10 text-gray-400 hover:text-white px-3 py-1.5 rounded text-xs font-bold transition-all">${t('edit', 'Edit')}</button>
                    <button onclick="removeGroupRecipe(${index})" class="bg-white/5 border border-white/10 text-red-400 hover:text-red-300 px-3 py-1.5 rounded text-xs font-bold transition-all">${t('remove', 'Remove')}</button>
                </div>
            </div>
        `).join('');
    lucide.createIcons();
}
function addGroupRecipe() {
    openGroupRecipeModal();
}
function editGroupRecipe(index) {
    openGroupRecipeModal(currentGroupRecipes[index], index);
}
function removeGroupRecipe(index) {
    currentGroupRecipes.splice(index, 1);
    renderGroupRecipesEditor();
}
function getRecipeBlueprint(recipe) {
    if (!recipe) return null;
    if (recipe.blueprint && typeof recipe.blueprint === 'object') {
        const item = recipe.blueprint.item || recipe.blueprint.name || '';
        if (!item) return null;
        return {
            item: item,
            amount: parseInt(recipe.blueprint.amount) || 1,
            consume: recipe.blueprint.consume === true
        };
    }
    if (typeof recipe.blueprint === 'string' && recipe.blueprint) {
        return {
            item: recipe.blueprint,
            amount: parseInt(recipe.blueprintAmount) || 1,
            consume: recipe.consumeBlueprint === true
        };
    }
    if (typeof recipe.blueprintItem === 'string' && recipe.blueprintItem) {
        return {
            item: recipe.blueprintItem,
            amount: parseInt(recipe.blueprintAmount) || 1,
            consume: recipe.consumeBlueprint === true
        };
    }
    return null;
}
function setBlueprintInputs(prefix, recipe) {
    const blueprint = getRecipeBlueprint(recipe);
    const enabled = document.getElementById(prefix + '-blueprint-enabled');
    const item = document.getElementById(prefix + '-blueprint-item');
    const amount = document.getElementById(prefix + '-blueprint-amount');
    const consume = document.getElementById(prefix + '-blueprint-consume');
    if (enabled) enabled.checked = !!blueprint;
    if (item) item.value = blueprint?.item || '';
    if (amount) amount.value = blueprint?.amount || 1;
    if (consume) consume.checked = blueprint?.consume === true;
}
function readBlueprintInputs(prefix) {
    const enabled = document.getElementById(prefix + '-blueprint-enabled');
    if (!enabled || !enabled.checked) return null;
    const item = document.getElementById(prefix + '-blueprint-item')?.value.trim() || '';
    if (!item) {
        showAlert(t('enterBlueprintItem', 'Please enter a blueprint item'));
        return false;
    }
    return {
        item: item,
        amount: Math.max(parseInt(document.getElementById(prefix + '-blueprint-amount')?.value) || 1, 1),
        consume: document.getElementById(prefix + '-blueprint-consume')?.checked === true
    };
}
function openGroupRecipeModal(recipe = null, index = null) {
    const modal = getElement('group-recipe-modal');
    const title = getElement('group-recipe-modal-title');
    getElement('edit-group-recipe-index').value = index !== null ? index : '';
    if (recipe) {
        title.textContent = t('editRecipe', 'Edit Recipe');
        getElement('group-recipe-input-name').value = recipe.name || '';
        getElement('group-recipe-input-label').value = recipe.label || '';
        getElement('group-recipe-result-item').value = recipe.result?.item || recipe.name || '';
        getElement('group-recipe-result-amount').value = recipe.result?.amount || 1;
        getElement('group-recipe-craft-time').value = recipe.craftTime || 5000;
        getElement('group-recipe-required-level').value = recipe.requiredLevel || 1;
        getElement('group-recipe-xp-reward').value = recipe.xpReward || 10;
        getElement('group-recipe-fail-chance').value = recipe.failChance || 10;
        getElement('group-recipe-skill-check').checked = recipe.skillCheck !== false;
        setBlueprintInputs('group-recipe', recipe);
        window.tempGroupIngredients = [...(recipe.ingredients || [])];
    } else {
        title.textContent = t('addRecipe', 'Add Recipe');
        getElement('group-recipe-input-name').value = '';
        getElement('group-recipe-input-label').value = '';
        getElement('group-recipe-result-item').value = '';
        getElement('group-recipe-result-amount').value = 1;
        getElement('group-recipe-craft-time').value = 5000;
        getElement('group-recipe-required-level').value = 1;
        getElement('group-recipe-xp-reward').value = 10;
        getElement('group-recipe-fail-chance').value = 10;
        getElement('group-recipe-skill-check').checked = true;
        setBlueprintInputs('group-recipe', null);
        window.tempGroupIngredients = [];
    }
    renderGroupIngredientsList();
    showModal(modal);
    lucide.createIcons();
    attachAutocompletesToGroupRecipeModal();
}
function closeGroupRecipeModal() {
    const modal = getElement('group-recipe-modal');
    hideModal(modal);
}
function renderGroupIngredientsList() {
    const container = document.getElementById('group-ingredients-list');
    if (!container) return;
    if (!window.tempGroupIngredients || window.tempGroupIngredients.length === 0) {
        container.innerHTML = '<div class="text-gray-500 text-center py-4 text-xs">' + t('noIngredientsYet', 'No ingredients added yet') + '</div>';
        return;
    }
    container.innerHTML = (window.tempGroupIngredients || []).map((ing, index) => `
        <div class="bg-[#1a1a1a] border border-white/10 rounded-lg p-3 flex items-center gap-3">
            <input type="text" placeholder="${t('itemName', 'Item name')}" value="${ing.item || ''}" onchange="updateGroupIngredient(${index}, 'item', this.value)" data-group-ingredient-input="${index}" class="flex-1 bg-[#0f0f0f] border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:outline-none focus:border-white/30 transition-colors">
            <button type="button" class="item-browse-btn" data-group-ingredient-browse="${index}" style="width:34px;height:34px;flex-shrink:0;"><i data-lucide="search" class="w-3.5 h-3.5"></i></button>
            <input type="number" placeholder="${t('amount', 'Amount')}" value="${ing.amount || 1}" min="1" onchange="updateGroupIngredient(${index}, 'amount', this.value)" class="w-20 bg-[#0f0f0f] border border-white/10 rounded-lg px-3 py-2 text-white text-sm text-center focus:outline-none focus:border-white/30 transition-colors">
            <button onclick="removeGroupIngredient(${index})" class="bg-red-500/10 border border-red-500/20 text-red-400 hover:text-red-300 hover:bg-red-500/20 p-2 rounded-lg transition-all"><i data-lucide="x" class="w-4 h-4"></i></button>
        </div>
    `).join('');
    lucide.createIcons();
    container.querySelectorAll('input[data-group-ingredient-input]').forEach(input => {
        const idx = parseInt(input.dataset.groupIngredientInput);
        attachItemAutocomplete(input, (itemName) => {
            updateGroupIngredient(idx, 'item', itemName);
        });
    });
}
function addGroupIngredient() {
    if (!window.tempGroupIngredients) window.tempGroupIngredients = [];
    window.tempGroupIngredients.push({ item: '', amount: 1 });
    renderGroupIngredientsList();
}
function updateGroupIngredient(index, field, value) {
    if (field === 'amount') value = parseInt(value) || 1;
    window.tempGroupIngredients[index][field] = value;
}
function removeGroupIngredient(index) {
    window.tempGroupIngredients.splice(index, 1);
    renderGroupIngredientsList();
}
function saveGroupRecipe() {
    const name = document.getElementById('group-recipe-input-name').value.trim();
    const label = document.getElementById('group-recipe-input-label').value.trim();
    if (!name) {
        showAlert(t('enterRecipeName', 'Please enter a recipe name'));
        return;
    }
    const blueprint = readBlueprintInputs('group-recipe');
    if (blueprint === false) return;
    const recipe = {
        name: name,
        label: label || name,
        ingredients: window.tempGroupIngredients || [],
        result: {
            item: document.getElementById('group-recipe-result-item').value.trim() || name,
            amount: parseInt(document.getElementById('group-recipe-result-amount').value) || 1
        },
        craftTime: parseInt(document.getElementById('group-recipe-craft-time').value) || 5000,
        requiredLevel: parseInt(document.getElementById('group-recipe-required-level').value) || 1,
        xpReward: parseInt(document.getElementById('group-recipe-xp-reward').value) || 10,
        failChance: parseInt(document.getElementById('group-recipe-fail-chance').value) || 10,
        skillCheck: document.getElementById('group-recipe-skill-check').checked
    };
    if (blueprint) recipe.blueprint = blueprint;
    const editIndex = document.getElementById('edit-group-recipe-index').value;
    if (editIndex !== '') {
        currentGroupRecipes[parseInt(editIndex)] = recipe;
    } else {
        currentGroupRecipes.push(recipe);
    }
    closeGroupRecipeModal();
    renderGroupRecipesEditor();
}
function saveRecipeGroups() {
    sendToLua('saveRecipeGroups', { groups: recipeGroups });
}
function valueOrDefault(value, fallback) {
    return value === null || value === undefined || Number.isNaN(value) ? fallback : value;
}
function renderCreatorSettings() {
    const settings = globalSettings || {};
    const crafting = settings.crafting || {};
    const skillCheck = crafting.skillCheck || {};
    const xpSystem = crafting.xpSystem || {};
    const failureSystem = crafting.failureSystem || {};
    const interaction = settings.interaction || {};
    const blips = settings.blips || {};
    return `
        <header class="px-8 py-6 flex justify-between items-center z-10 animate-fade-in border-b border-white/[0.03]">
            <div class="flex items-center gap-4">
                <div class="w-10 h-10 bg-white/5 rounded-xl flex items-center justify-center border border-white/10">
                    <i data-lucide="settings" class="w-5 h-5 text-white/70"></i>
                </div>
                <div>
                    <h2 class="text-white text-xl font-bold tracking-tight">${t('settings', 'Settings')}</h2>
                    <p class="text-gray-600 text-xs">${t('configureSystem', 'Configure your crafting system')}</p>
                </div>
            </div>
            <div class="flex items-center gap-3">
                <button onclick="saveGlobalSettings()" class="bg-white text-black hover:bg-gray-200 px-4 py-2.5 rounded-lg text-xs font-bold transition-all shadow-[0_0_15px_rgba(255,255,255,0.2)] flex items-center gap-2">
                    <i data-lucide="save" class="w-3.5 h-3.5"></i> ${t('save', 'Save')}
                </button>
                <button onclick="closeCreator()" class="bg-white/5 border border-white/10 text-gray-400 hover:text-white hover:bg-white/10 px-4 py-2.5 rounded-lg text-xs font-bold transition-all">${t('close', 'Close')}</button>
            </div>
        </header>
        <div class="flex-1 overflow-y-auto px-8 py-6 z-10 scrollbar-hide animate-fade-in">
            <div class="bg-amber-500/10 border border-amber-500/30 rounded-xl p-4 mb-6 flex items-center gap-3">
                <i data-lucide="alert-triangle" class="w-5 h-5 text-amber-500 shrink-0"></i>
                <p class="text-amber-200 text-xs">${t('settingsRestartWarning', 'Some settings may require a resource restart to take effect.')}</p>
            </div>
            <div class="settings-section">
                <div class="settings-section-title">${t('settingsGeneral', 'General')}</div>
                <div class="settings-grid">
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('debugMode', 'Debug Mode')}</div>
                                <div class="setting-item-desc">${t('debugModeDesc', 'Console logging for troubleshooting')}</div>
                            </div>
                            <div class="setting-item-control">
                                <div class="toggle-switch ${settings.debug ? 'active' : ''}" data-setting="debug"></div>
                            </div>
                        </div>
                    </div>
                    <div class="setting-item with-input">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('creatorCommand', 'Creator Command')}</div>
                                <div class="setting-item-desc">${t('creatorCommandDesc', 'Command to open creator panel')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="text" class="settings-input" value="${settings.commands?.creator || 'craftingcreator'}" data-setting="cmd-creator">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item with-input">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('commandAlias', 'Command Alias')}</div>
                                <div class="setting-item-desc">${t('commandAliasDesc', 'Short alias for creator command')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="text" class="settings-input" value="${settings.commands?.creatorAlias || 'cc'}" data-setting="cmd-alias">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="settings-section">
                <div class="settings-section-title">${t('settingsSkillCheck', 'Skill Check')}</div>
                <div class="settings-grid">
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('enableSkillCheck', 'Enable Skill Check')}</div>
                                <div class="setting-item-desc">${t('enableSkillCheckDesc', 'Require skill check for crafting')}</div>
                            </div>
                            <div class="setting-item-control">
                                <div class="toggle-switch ${skillCheck.enabled !== false ? 'active' : ''}" data-setting="skillcheck-enabled"></div>
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('difficulty', 'Difficulty')}</div>
                                <div class="setting-item-desc">${t('difficultyDesc', 'Default skill check difficulty')}</div>
                            </div>
                            <div class="setting-item-control" style="width: 120px;">
                                ${createSettingsDropdown('skillcheck-difficulty', [
                                    { value: 'easy', label: t('difficultyEasy', 'Easy') },
                                    { value: 'medium', label: t('difficultyMedium', 'Medium') },
                                    { value: 'hard', label: t('difficultyHard', 'Hard') }
                                ], skillCheck.difficulty || 'medium')}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="settings-section">
                <div class="settings-section-title">${t('settingsXpSystem', 'XP System')}</div>
                <div class="settings-grid">
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('enableXpSystem', 'Enable XP System')}</div>
                                <div class="setting-item-desc">${t('enableXpSystemDesc', 'Track player crafting experience')}</div>
                            </div>
                            <div class="setting-item-control">
                                <div class="toggle-switch ${xpSystem.enabled !== false ? 'active' : ''}" data-setting="xp-enabled"></div>
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('xpPerCraft', 'XP Per Craft')}</div>
                                <div class="setting-item-desc">${t('xpPerCraftDesc', 'Experience gained per successful craft')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(xpSystem.xpPerCraft, 10)}" data-setting="xp-percraft" min="0">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('xpPerLevel', 'XP Per Level')}</div>
                                <div class="setting-item-desc">${t('xpPerLevelDesc', 'XP required for each level')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(xpSystem.xpPerLevel, 100)}" data-setting="xp-perlevel" min="1">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('maxLevel', 'Max Level')}</div>
                                <div class="setting-item-desc">${t('maxLevelDesc', 'Maximum crafting level')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(xpSystem.maxLevel, 100)}" data-setting="xp-maxlevel" min="1">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="settings-section">
                <div class="settings-section-title">${t('settingsFailure', 'Failure System')}</div>
                <div class="settings-grid">
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('enableFailure', 'Enable Failure System')}</div>
                                <div class="setting-item-desc">${t('enableFailureDesc', 'Allow crafting to fail randomly')}</div>
                            </div>
                            <div class="setting-item-control">
                                <div class="toggle-switch ${failureSystem.enabled !== false ? 'active' : ''}" data-setting="fail-enabled"></div>
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('baseFailChance', 'Base Fail Chance')}</div>
                                <div class="setting-item-desc">${t('baseFailChanceDesc', 'Starting failure percentage')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(failureSystem.baseFailChance, 10)}" data-setting="fail-chance" min="0" max="100">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('reductionPerLevel', 'Reduction Per Level')}</div>
                                <div class="setting-item-desc">${t('reductionPerLevelDesc', 'Fail chance reduction per level')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(failureSystem.failChanceReduction, 0.5)}" data-setting="fail-reduction" min="0" step="0.1">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('loseItemsOnFail', 'Lose Items On Fail')}</div>
                                <div class="setting-item-desc">${t('loseItemsOnFailDesc', 'Remove materials when crafting fails')}</div>
                            </div>
                            <div class="setting-item-control">
                                <div class="toggle-switch ${failureSystem.loseItemsOnFail !== false ? 'active' : ''}" data-setting="fail-loseitems"></div>
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('itemsLostPercent', '% Items Lost')}</div>
                                <div class="setting-item-desc">${t('itemsLostPercentDesc', 'Percentage of materials lost on fail')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(failureSystem.losePercentOnFail, 50)}" data-setting="fail-losepercent" min="0" max="100">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="settings-section">
                <div class="settings-section-title">${t('settingsAnimations', 'Animations')}</div>
                <div class="settings-grid">
                    <div class="setting-item with-input">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('craftingAnimDict', 'Crafting Animation Dict')}</div>
                                <div class="setting-item-desc">${t('craftingAnimDictDesc', 'Animation dictionary for crafting')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="text" class="settings-input" value="${crafting.animations?.crafting?.dict || 'mini@repair'}" data-setting="anim-craft-dict">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item with-input">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('craftingAnimName', 'Crafting Animation Name')}</div>
                                <div class="setting-item-desc">${t('craftingAnimNameDesc', 'Animation name for crafting')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="text" class="settings-input" value="${crafting.animations?.crafting?.anim || 'fixing_a_player'}" data-setting="anim-craft-anim">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('craftingDuration', 'Crafting Duration')}</div>
                                <div class="setting-item-desc">${t('craftingDurationDesc', 'Default crafting time in ms')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(crafting.animations?.crafting?.duration, 5000)}" data-setting="anim-craft-duration" min="1000">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="settings-section">
                <div class="settings-section-title">${t('settingsInteraction', 'Interaction')}</div>
                <div class="settings-grid">
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('useTargetSystem', 'Use Target System')}</div>
                                <div class="setting-item-desc">${t('useTargetSystemDesc', 'Enable ox_target integration')}</div>
                            </div>
                            <div class="setting-item-control">
                                <div class="toggle-switch ${interaction.useTarget !== false ? 'active' : ''}" data-setting="interact-target"></div>
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('useMarkers', 'Use Markers')}</div>
                                <div class="setting-item-desc">${t('useMarkersDesc', 'Show markers at bench locations')}</div>
                            </div>
                            <div class="setting-item-control">
                                <div class="toggle-switch ${interaction.useMarker !== false ? 'active' : ''}" data-setting="interact-marker"></div>
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('interactionDistance', 'Interaction Distance')}</div>
                                <div class="setting-item-desc">${t('interactionDistanceDesc', 'Distance to interact with bench')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(interaction.interactionDistance, 2.0)}" data-setting="interact-distance" min="0.5" step="0.5">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('drawDistance', 'Draw Distance')}</div>
                                <div class="setting-item-desc">${t('drawDistanceDesc', 'Distance to draw markers')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(interaction.drawDistance, 10.0)}" data-setting="interact-drawdist" min="1" step="1">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="settings-section">
                <div class="settings-section-title">${t('settingsBlips', 'Map Blips')}</div>
                <div class="settings-grid">
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('enableBlips', 'Enable Blips')}</div>
                                <div class="setting-item-desc">${t('enableBlipsDesc', 'Show bench locations on map')}</div>
                            </div>
                            <div class="setting-item-control">
                                <div class="toggle-switch ${blips.enabled !== false ? 'active' : ''}" data-setting="blips-enabled"></div>
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('craftingBlipSprite', 'Crafting Blip Sprite')}</div>
                                <div class="setting-item-desc">${t('craftingBlipSpriteDesc', 'Blip icon for crafting benches')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(blips.crafting?.sprite, 566)}" data-setting="blips-craft-sprite" min="1">
                            </div>
                        </div>
                    </div>
                    <div class="setting-item">
                        <div class="setting-item-header">
                            <div class="setting-item-info">
                                <div class="setting-item-label">${t('craftingBlipColor', 'Crafting Blip Color')}</div>
                                <div class="setting-item-desc">${t('craftingBlipColorDesc', 'Color ID for crafting blips')}</div>
                            </div>
                            <div class="setting-item-control">
                                <input type="number" class="settings-input-inline" value="${valueOrDefault(blips.crafting?.color, 2)}" data-setting="blips-craft-color" min="0">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `;
}
function createSettingsDropdown(name, options, currentValue) {
    const selectedOption = options.find(o => o.value === currentValue) || options[0];
    return `
        <div class="custom-dropdown settings-dropdown" data-setting="${name}">
            <div class="custom-dropdown-trigger" data-dropdown-name="${name}">
                <span>${selectedOption.label}</span>
                <i data-lucide="chevron-down" class="custom-dropdown-arrow w-4 h-4"></i>
            </div>
            <div class="custom-dropdown-menu">
                ${options.map(opt => `
                    <div class="custom-dropdown-option ${opt.value === currentValue ? 'selected' : ''}" data-value="${opt.value}">
                        <i data-lucide="check" class="option-check w-4 h-4"></i>
                        <span>${opt.label}</span>
                    </div>
                `).join('')}
            </div>
        </div>
    `;
}
function initSettingsListeners() {
    document.querySelectorAll('.settings-section .toggle-switch').forEach(toggle => {
        toggle.addEventListener('click', function(e) {
            e.stopPropagation();
            this.classList.toggle('active');
        });
    });
    document.querySelectorAll('.settings-dropdown').forEach(dropdown => {
        const trigger = dropdown.querySelector('.custom-dropdown-trigger');
        const menu = dropdown.querySelector('.custom-dropdown-menu');
        trigger.addEventListener('click', function(e) {
            e.stopPropagation();
            e.preventDefault();
            const isOpen = menu.classList.contains('open');
            document.querySelectorAll('.settings-dropdown').forEach(d => {
                if (d !== dropdown) d.classList.remove('open');
            });
            document.querySelectorAll('.settings-dropdown .custom-dropdown-menu.open').forEach(m => {
                if (m !== menu) m.classList.remove('open');
            });
            document.querySelectorAll('.settings-dropdown .custom-dropdown-trigger.open').forEach(t => {
                if (t !== trigger) t.classList.remove('open');
            });
            if (isOpen) {
                dropdown.classList.remove('open');
                trigger.classList.remove('open');
                menu.classList.remove('open');
            } else {
                dropdown.classList.add('open');
                trigger.classList.add('open');
                menu.classList.add('open');
            }
        });
        menu.querySelectorAll('.custom-dropdown-option').forEach(option => {
            option.addEventListener('click', function(e) {
                e.stopPropagation();
                e.preventDefault();
                menu.querySelectorAll('.custom-dropdown-option').forEach(o => o.classList.remove('selected'));
                option.classList.add('selected');
                trigger.querySelector('span').textContent = option.querySelector('span').textContent;
                dropdown.classList.remove('open');
                trigger.classList.remove('open');
                menu.classList.remove('open');
            });
        });
    });
    if (!window.settingsDropdownListenerAdded) {
        window.settingsDropdownListenerAdded = true;
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.settings-dropdown')) {
                document.querySelectorAll('.settings-dropdown').forEach(d => d.classList.remove('open'));
                document.querySelectorAll('.settings-dropdown .custom-dropdown-menu.open').forEach(m => m.classList.remove('open'));
                document.querySelectorAll('.settings-dropdown .custom-dropdown-trigger.open').forEach(t => t.classList.remove('open'));
            }
        });
    }
    lucide.createIcons();
}
function getSettingValue(settingName, type = 'text') {
    const toggle = document.querySelector(`.toggle-switch[data-setting="${settingName}"]`);
    if (toggle) {
        return toggle.classList.contains('active');
    }
    const dropdown = document.querySelector(`.custom-dropdown[data-setting="${settingName}"]`);
    if (dropdown) {
        const selected = dropdown.querySelector('.custom-dropdown-option.selected');
        return selected ? selected.dataset.value : null;
    }
    const input = document.querySelector(`input[data-setting="${settingName}"]`);
    if (input) {
        if (type === 'number') {
            const value = parseFloat(input.value);
            return Number.isFinite(value) ? value : null;
        } else if (type === 'int') {
            const value = parseInt(input.value, 10);
            return Number.isFinite(value) ? value : null;
        }
        return input.value;
    }
    return null;
}
function saveGlobalSettings() {
    const newSettings = {
        debug: getSettingValue('debug'),
        commands: {
            creator: getSettingValue('cmd-creator') || 'craftingcreator',
            creatorAlias: getSettingValue('cmd-alias') || 'cc'
        },
        crafting: {
            skillCheck: {
                enabled: getSettingValue('skillcheck-enabled'),
                difficulty: getSettingValue('skillcheck-difficulty') || 'medium',
                inputs: globalSettings?.crafting?.skillCheck?.inputs || ['w', 'a', 's', 'd']
            },
            xpSystem: {
                enabled: getSettingValue('xp-enabled'),
                xpPerCraft: valueOrDefault(getSettingValue('xp-percraft', 'int'), 10),
                xpPerLevel: valueOrDefault(getSettingValue('xp-perlevel', 'int'), 100),
                maxLevel: valueOrDefault(getSettingValue('xp-maxlevel', 'int'), 100),
                xpBonusOnLevelUp: valueOrDefault(globalSettings?.crafting?.xpSystem?.xpBonusOnLevelUp, 50)
            },
            failureSystem: {
                enabled: getSettingValue('fail-enabled'),
                baseFailChance: valueOrDefault(getSettingValue('fail-chance', 'int'), 10),
                failChanceReduction: valueOrDefault(getSettingValue('fail-reduction', 'number'), 0.5),
                loseItemsOnFail: getSettingValue('fail-loseitems'),
                losePercentOnFail: valueOrDefault(getSettingValue('fail-losepercent', 'int'), 50)
            },
            animations: {
                crafting: {
                    dict: getSettingValue('anim-craft-dict') || 'mini@repair',
                    anim: getSettingValue('anim-craft-anim') || 'fixing_a_player',
                    duration: valueOrDefault(getSettingValue('anim-craft-duration', 'int'), 5000)
                }
            },
            sounds: globalSettings?.crafting?.sounds || {
                craftStart: { sound: 'PIN_BUTTON', set: 'ATM_SOUNDS' },
                craftSuccess: { sound: 'PICK_UP', set: 'HUD_FRONTEND_DEFAULT_SOUNDSET' },
                craftFail: { sound: 'ERROR', set: 'HUD_FRONTEND_DEFAULT_SOUNDSET' }
            }
        },
        interaction: {
            useTarget: getSettingValue('interact-target'),
            useMarker: getSettingValue('interact-marker'),
            interactionKey: valueOrDefault(globalSettings?.interaction?.interactionKey, 38),
            markerType: valueOrDefault(globalSettings?.interaction?.markerType, 27),
            markerColor: globalSettings?.interaction?.markerColor || [255, 255, 255, 100],
            markerSize: globalSettings?.interaction?.markerSize || [1.0, 1.0, 0.5],
            interactionDistance: valueOrDefault(getSettingValue('interact-distance', 'number'), 2.0),
            drawDistance: valueOrDefault(getSettingValue('interact-drawdist', 'number'), 10.0)
        },
        blips: {
            enabled: getSettingValue('blips-enabled'),
            crafting: {
                sprite: valueOrDefault(getSettingValue('blips-craft-sprite', 'int'), 566),
                color: valueOrDefault(getSettingValue('blips-craft-color', 'int'), 2),
                scale: valueOrDefault(globalSettings?.blips?.crafting?.scale, 0.7),
                display: valueOrDefault(globalSettings?.blips?.crafting?.display, 4)
            }
        },
        permissions: globalSettings?.permissions || {
            creatorAccess: {
                useAcePermission: true,
                acePermission: 'fearx.crafting.creator',
                useFrameworkGroup: true,
                frameworkGroups: ['admin', 'superadmin', 'god']
            }
        },
        oxInventory: globalSettings?.oxInventory || {
            imagePath: 'nui://ox_inventory/web/images/',
            benchStash: { enabled: false, slots: 10, weight: 50000 }
        }
    };
    globalSettings = newSettings;
    sendToLua('saveSettings', newSettings);
    sendToLua('notify', {
        title: 'Settings',
        message: t('settingsSaved', 'Settings saved successfully!'),
        type: 'success',
        duration: 3000
    });
}
function attachBenchListeners() {
    document.querySelectorAll('.teleport-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            sendToLua('teleportToBench', { id: btn.dataset.id });
        });
    });
    document.querySelectorAll('.edit-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const bench = benchesData.find(b => b.id === btn.dataset.id);
            if (bench) openBenchModal(bench);
        });
    });
    document.querySelectorAll('.delete-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const bench = benchesData.find(b => b.id === btn.dataset.id);
            if (bench) {
                showDeleteModal(t('confirmDeleteBench', 'Are you sure you want to delete this bench?'), () => {
                    sendToLua('deleteBench', { id: bench.id });
                    benchesData = benchesData.filter(b => b.id !== bench.id);
                    renderCreatorPage();
                });
            }
        });
    });
}
function openBenchModal(bench = null) {
    const modal = document.getElementById('bench-modal');
    const title = document.getElementById('bench-modal-title');
    if (bench) {
        title.textContent = t('editBench', 'Edit Bench');
        document.getElementById('edit-bench-id').value = bench.id;
        document.getElementById('bench-input-name').value = bench.name;
        document.getElementById('bench-input-x').value = bench.coords?.x?.toFixed(2) || 0;
        document.getElementById('bench-input-y').value = bench.coords?.y?.toFixed(2) || 0;
        document.getElementById('bench-input-z').value = bench.coords?.z?.toFixed(2) || 0;
        document.getElementById('bench-input-heading').value = bench.heading || 0;
        document.getElementById('heading-value').textContent = bench.heading || 0;
        document.getElementById('bench-input-blip').checked = bench.blipEnabled !== false;
        document.getElementById('owner-license-input').value = bench.ownerLicense || '';
        document.getElementById('owner-player-id').value = '';
        document.getElementById('owner-name-display').value = bench.ownerName || '';
        if (bench.ownerLicense) {
            document.getElementById('owner-info-display').classList.remove('hidden');
        } else {
            document.getElementById('owner-info-display').classList.add('hidden');
        }
        currentRecipes = bench.recipes || [];
        selectedRecipeGroupIds = bench.recipeGroupIds || [];
        benchRecipeSearch = '';
        currentAccessData = {
            groups: bench.accessData?.groups || [],
            jobs: bench.accessData?.jobs || [],
            gangs: bench.accessData?.gangs || [],
            roles: bench.accessData?.roles || []
        };
        var savedBenchType = bench.type || 'crafting';
        var savedPropModel = bench.propModel || 'workbench';
        var savedAccessType = bench.accessType || 'public';
        populateDropdowns();
        setDropdownValue('benchType', savedBenchType);
        setPropModelValue(savedPropModel);
        setDropdownValue('accessType', savedAccessType);
    } else {
        title.textContent = t('createBench', 'Create Bench');
        document.getElementById('edit-bench-id').value = '';
        document.getElementById('bench-input-name').value = '';
        document.getElementById('bench-input-x').value = playerCoords.x.toFixed(2);
        document.getElementById('bench-input-y').value = playerCoords.y.toFixed(2);
        document.getElementById('bench-input-z').value = playerCoords.z.toFixed(2);
        document.getElementById('bench-input-heading').value = 0;
        document.getElementById('heading-value').textContent = 0;
        document.getElementById('bench-input-blip').checked = true;
        document.getElementById('owner-license-input').value = '';
        document.getElementById('owner-player-id').value = '';
        document.getElementById('owner-name-display').value = '';
        document.getElementById('owner-info-display').classList.add('hidden');
        currentRecipes = [];
        selectedRecipeGroupIds = [];
        benchRecipeSearch = '';
        currentAccessData = { groups: [], jobs: [], gangs: [], roles: [] };
        populateDropdowns();
        setDropdownValue('benchType', 'crafting');
        setPropModelValue('workbench');
        setDropdownValue('accessType', 'public');
    }
    updateAccessSections();
    renderRecipesEditor();
    switchModalTab('basic');
    showModal(modal);
    lucide.createIcons();
}
function closeBenchModal() {
    const modal = getElement('bench-modal');
    hideModal(modal);
}
function saveBench() {
    const id = document.getElementById('edit-bench-id').value;
    const name = document.getElementById('bench-input-name').value.trim();
    const x = parseFloat(document.getElementById('bench-input-x').value);
    const y = parseFloat(document.getElementById('bench-input-y').value);
    const z = parseFloat(document.getElementById('bench-input-z').value);
    const heading = parseFloat(document.getElementById('bench-input-heading').value);
    const blipEnabled = document.getElementById('bench-input-blip').checked;
    const accessType = getDropdownValue('accessType');
    if (!name) {
        showAlert(t('enterBenchName', 'Please enter a bench name'));
        return;
    }
    let ownerLicense = null;
    if (accessType === 'private') {
        ownerLicense = document.getElementById('owner-license-input').value.trim();
        if (!ownerLicense) {
            showAlert(t('enterOwnerLicense', 'Please enter an owner license for private bench'));
            return;
        }
    }
    const allRecipesFromGroups = [];
    selectedRecipeGroupIds.forEach(groupId => {
        const group = recipeGroups.find(g => g.id === groupId);
        if (group && group.recipes) {
            allRecipesFromGroups.push(...group.recipes);
        }
    });
    const benchData = {
        id: id || null,
        name: name,
        type: getDropdownValue('benchType'),
        coords: { x, y, z },
        heading: heading,
        propModel: document.getElementById('prop-model-selector')?.dataset.value || 'workbench',
        accessType: accessType,
        accessData: currentAccessData,
        ownerLicense: ownerLicense,
        recipes: allRecipesFromGroups,
        recipeGroupIds: selectedRecipeGroupIds,
        settings: {},
        blipEnabled: blipEnabled
    };
    sendToLua('saveBench', benchData);
    if (id) {
        const index = benchesData.findIndex(b => b.id === id);
        if (index !== -1) {
            benchesData[index] = { ...benchesData[index], ...benchData };
        }
    } else {
        benchesData.push(benchData);
    }
    closeBenchModal();
    renderCreatorPage();
}
function populateDropdowns() {
    const benchTypeMenu = document.getElementById('benchType-menu');
    benchTypeMenu.innerHTML = Object.entries(benchTypes).map(([key, value]) => `
        <div class="custom-dropdown-option" data-value="${key}">
            <i data-lucide="${value.icon}" class="w-4 h-4"></i>
            <span>${value.label}</span>
        </div>
    `).join('');
    const accessTypeMenu = document.getElementById('accessType-menu');
    accessTypeMenu.innerHTML = Object.entries(accessTypes).map(([key, value]) => `
        <div class="custom-dropdown-option" data-value="${key}">
            <span>${value.label}</span>
        </div>
    `).join('');
    initializeDropdowns();
}
function initializeDropdowns() {
    document.querySelectorAll('.custom-dropdown').forEach(dropdown => {
        const trigger = dropdown.querySelector('.custom-dropdown-trigger');
        const menu = dropdown.querySelector('.custom-dropdown-menu');
        const newTrigger = trigger.cloneNode(true);
        trigger.parentNode.replaceChild(newTrigger, trigger);
        newTrigger.addEventListener('click', (e) => {
            e.stopPropagation();
            const isOpen = menu.classList.contains('open');
            document.querySelectorAll('.custom-dropdown-menu').forEach(m => m.classList.remove('open'));
            document.querySelectorAll('.custom-dropdown-trigger').forEach(t => t.classList.remove('open'));
            if (!isOpen) {
                menu.classList.add('open');
                newTrigger.classList.add('open');
            }
        });
        menu.querySelectorAll('.custom-dropdown-option').forEach(option => {
            const newOption = option.cloneNode(true);
            option.parentNode.replaceChild(newOption, option);
            newOption.addEventListener('click', () => {
                const value = newOption.dataset.value;
                const text = newOption.querySelector('span')?.textContent || newOption.textContent;
                newTrigger.querySelector('.dropdown-selected-text').textContent = text;
                newTrigger.dataset.value = value;
                menu.querySelectorAll('.custom-dropdown-option').forEach(o => o.classList.remove('selected'));
                newOption.classList.add('selected');
                dropdown.classList.remove('open');
                menu.classList.remove('open');
                newTrigger.classList.remove('open');
                if (dropdown.dataset.dropdownId === 'accessType') {
                    updateAccessSections();
                }
            });
        });
    });
    if (!window.dropdownDocClickAdded) {
        window.dropdownDocClickAdded = true;
        document.addEventListener('click', () => {
            document.querySelectorAll('.custom-dropdown-menu').forEach(m => m.classList.remove('open'));
            document.querySelectorAll('.custom-dropdown-trigger').forEach(t => t.classList.remove('open'));
        });
    }
}
function getDropdownValue(id) {
    const dropdown = document.querySelector(`[data-dropdown-id="${id}"] .custom-dropdown-trigger`);
    return dropdown?.dataset.value || '';
}
function setDropdownValue(id, value) {
    const dropdown = document.querySelector(`[data-dropdown-id="${id}"]`);
    if (!dropdown) return;
    const trigger = dropdown.querySelector('.custom-dropdown-trigger');
    const option = dropdown.querySelector(`.custom-dropdown-option[data-value="${value}"]`);
    if (option) {
        const text = option.querySelector('span')?.textContent || option.textContent;
        trigger.querySelector('.dropdown-selected-text').textContent = text;
        trigger.dataset.value = value;
        dropdown.querySelectorAll('.custom-dropdown-option').forEach(o => o.classList.remove('selected'));
        option.classList.add('selected');
    }
}
function updateAccessSections() {
    const accessType = getDropdownValue('accessType');
    document.querySelectorAll('.access-section').forEach(section => section.classList.add('hidden'));
    switch(accessType) {
        case 'group':
            document.getElementById('access-groups').classList.remove('hidden');
            renderGroupTags();
            break;
        case 'job':
            document.getElementById('access-jobs').classList.remove('hidden');
            renderJobsList();
            break;
        case 'gang':
            document.getElementById('access-gangs').classList.remove('hidden');
            renderGangsList();
            break;
        case 'discord':
            document.getElementById('access-discord').classList.remove('hidden');
            renderDiscordTags();
            break;
        case 'private':
            document.getElementById('access-private').classList.remove('hidden');
            initPrivateOwnerLookup();
            break;
    }
}
function renderGroupTags() {
    const container = document.getElementById('groups-tags');
    container.innerHTML = (currentAccessData.groups || []).map((group, index) => `
        <span class="tag">
            ${group}
            <button onclick="removeGroup(${index})">&times;</button>
        </span>
    `).join('');
}
function addGroup(group) {
    if (!group || currentAccessData.groups.includes(group)) return;
    currentAccessData.groups.push(group);
    renderGroupTags();
}
function removeGroup(index) {
    currentAccessData.groups.splice(index, 1);
    renderGroupTags();
}
function renderJobsList() {
    const container = document.getElementById('jobs-list');
    container.innerHTML = (currentAccessData.jobs || []).map((job, index) => `
        <div class="access-item">
            <input type="text" placeholder="${t('job', 'Job')}" value="${job.name || ''}" onchange="updateJob(${index}, 'name', this.value)">
            <input type="number" placeholder="${t('minGrade', 'Min Grade')}" value="${job.minGrade || 0}" min="0" onchange="updateJob(${index}, 'minGrade', this.value)">
            <button onclick="removeJob(${index})"><i data-lucide="x" class="w-4 h-4"></i></button>
        </div>
    `).join('');
    lucide.createIcons();
}
function addJob() {
    if (!currentAccessData.jobs) currentAccessData.jobs = [];
    currentAccessData.jobs.push({ name: '', minGrade: 0 });
    renderJobsList();
}
function updateJob(index, field, value) {
    if (field === 'minGrade') value = parseInt(value) || 0;
    currentAccessData.jobs[index][field] = value;
}
function removeJob(index) {
    currentAccessData.jobs.splice(index, 1);
    renderJobsList();
}
function renderGangsList() {
    const container = document.getElementById('gangs-list');
    container.innerHTML = (currentAccessData.gangs || []).map((gang, index) => `
        <div class="access-item">
            <input type="text" placeholder="${t('gang', 'Gang')}" value="${gang.name || ''}" onchange="updateGang(${index}, 'name', this.value)">
            <input type="number" placeholder="${t('minGrade', 'Min Grade')}" value="${gang.minGrade || 0}" min="0" onchange="updateGang(${index}, 'minGrade', this.value)">
            <button onclick="removeGang(${index})"><i data-lucide="x" class="w-4 h-4"></i></button>
        </div>
    `).join('');
    lucide.createIcons();
}
function addGang() {
    if (!currentAccessData.gangs) currentAccessData.gangs = [];
    currentAccessData.gangs.push({ name: '', minGrade: 0 });
    renderGangsList();
}
function updateGang(index, field, value) {
    if (field === 'minGrade') value = parseInt(value) || 0;
    currentAccessData.gangs[index][field] = value;
}
function removeGang(index) {
    currentAccessData.gangs.splice(index, 1);
    renderGangsList();
}
function renderDiscordTags() {
    const container = document.getElementById('discord-tags');
    container.innerHTML = (currentAccessData.roles || []).map((role, index) => `
        <span class="tag">
            ${role}
            <button onclick="removeDiscordRole(${index})">&times;</button>
        </span>
    `).join('');
}
function addDiscordRole(role) {
    if (!role) return;
    if (!currentAccessData.roles) currentAccessData.roles = [];
    if (currentAccessData.roles.includes(role)) return;
    currentAccessData.roles.push(role);
    renderDiscordTags();
}
function removeDiscordRole(index) {
    currentAccessData.roles.splice(index, 1);
    renderDiscordTags();
}
function loadOnlinePlayers() {
    sendToLua('getOnlinePlayers', {});
}
function initPrivateOwnerLookup() {
    const grabBtn = document.getElementById('grab-player-info-btn');
    const playerIdInput = document.getElementById('owner-player-id');
    const newBtn = grabBtn.cloneNode(true);
    grabBtn.parentNode.replaceChild(newBtn, grabBtn);
    newBtn.addEventListener('click', function() {
        const playerId = playerIdInput.value.trim();
        if (!playerId) {
            sendToLua('notify', { title: 'Error', message: t('enterPlayerId', 'Enter player ID...'), type: 'error' });
            return;
        }
        sendToLua('getPlayerInfo', { playerId: parseInt(playerId) });
    });
    lucide.createIcons();
}
function displayOwnerInfo(data) {
    const infoDisplay = document.getElementById('owner-info-display');
    const nameInput = document.getElementById('owner-name-display');
    const licenseInput = document.getElementById('owner-license-input');
    if (data && data.name && data.license) {
        nameInput.value = data.name;
        licenseInput.value = data.license;
        infoDisplay.classList.remove('hidden');
    } else {
        sendToLua('notify', { title: 'Error', message: t('playerNotFound', 'Player not found or offline'), type: 'error' });
    }
}
function renderRecipesEditor() {
    const container = document.getElementById('recipes-editor-list');
    if (!container) return;
    const searchInput = document.getElementById('bench-recipe-search');
    if (searchInput && searchInput.value !== benchRecipeSearch) {
        searchInput.value = benchRecipeSearch;
    }
    const filteredGroups = recipeGroups.filter(g =>
        !benchRecipeSearch || g.name.toLowerCase().includes(benchRecipeSearch.toLowerCase())
    );
    const selectedCount = document.getElementById('bench-selected-count');
    if (selectedCount) {
        selectedCount.textContent = `${selectedRecipeGroupIds.length} ${t('selected', 'selected')}`;
    }
    container.innerHTML = filteredGroups.length === 0 ?
        '<div class="text-gray-500 text-center py-10 text-sm">' + t('noRecipeGroupsFound', 'No recipe groups found') + '</div>' :
        filteredGroups.map(group => {
            const isSelected = selectedRecipeGroupIds.includes(group.id);
            const recipeCount = (group.recipes || []).length;
            return `
                <div class="bg-[#1a1a1a] border ${isSelected ? 'border-white/30' : 'border-white/10'} rounded-lg p-3 flex items-center gap-3 cursor-pointer hover:border-white/20 transition-colors" onclick="toggleRecipeGroup('${group.id}')">
                    <div class="w-5 h-5 rounded border ${isSelected ? 'bg-white border-white' : 'bg-transparent border-white/30'} flex items-center justify-center shrink-0">
                        ${isSelected ? '<i data-lucide="check" class="w-3 h-3 text-black"></i>' : ''}
                    </div>
                    <div class="w-8 h-8 bg-white/10 rounded-md flex items-center justify-center shrink-0">
                        <i data-lucide="folder" class="w-4 h-4 text-white"></i>
                    </div>
                    <div class="flex-1 min-w-0">
                        <div class="text-white font-medium text-sm truncate">${group.name}</div>
                        <div class="text-gray-500 text-xs">${recipeCount} ${t('recipes', 'recipes')}</div>
                    </div>
                </div>
            `;
        }).join('');
    lucide.createIcons();
    if (!searchInput.dataset.listenerAttached) {
        searchInput.addEventListener('input', (e) => {
            benchRecipeSearch = e.target.value;
            renderRecipesEditor();
        });
        searchInput.dataset.listenerAttached = 'true';
    }
}
function toggleRecipeGroup(groupId) {
    const index = selectedRecipeGroupIds.indexOf(groupId);
    if (index === -1) {
        selectedRecipeGroupIds.push(groupId);
    } else {
        selectedRecipeGroupIds.splice(index, 1);
    }
    renderRecipesEditor();
}
function openRecipeModal(recipe = null, index = null) {
    const modal = document.getElementById('recipe-modal');
    const title = document.getElementById('recipe-modal-title');
    if (recipe) {
        title.textContent = t('editRecipe', 'Edit Recipe');
        document.getElementById('edit-recipe-index').value = index;
        document.getElementById('recipe-input-name').value = recipe.name || '';
        document.getElementById('recipe-input-label').value = recipe.label || '';
        document.getElementById('recipe-result-item').value = recipe.result?.item || '';
        document.getElementById('recipe-result-amount').value = recipe.result?.amount || 1;
        document.getElementById('recipe-craft-time').value = recipe.craftTime || 5000;
        document.getElementById('recipe-required-level').value = recipe.requiredLevel || 1;
        document.getElementById('recipe-xp-reward').value = recipe.xpReward || 10;
        document.getElementById('recipe-fail-chance').value = recipe.failChance || 10;
        document.getElementById('recipe-skill-check').checked = recipe.skillCheck !== false;
        setBlueprintInputs('recipe', recipe);
        renderIngredientsEditor(recipe.ingredients || []);
    } else {
        title.textContent = t('addRecipe', 'Add Recipe');
        document.getElementById('edit-recipe-index').value = '';
        document.getElementById('recipe-input-name').value = '';
        document.getElementById('recipe-input-label').value = '';
        document.getElementById('recipe-result-item').value = '';
        document.getElementById('recipe-result-amount').value = 1;
        document.getElementById('recipe-craft-time').value = 5000;
        document.getElementById('recipe-required-level').value = 1;
        document.getElementById('recipe-xp-reward').value = 10;
        document.getElementById('recipe-fail-chance').value = 10;
        document.getElementById('recipe-skill-check').checked = true;
        setBlueprintInputs('recipe', null);
        renderIngredientsEditor([]);
    }
    modal.classList.remove('hidden');
    lucide.createIcons();
    attachAutocompletesToRecipeModal();
}
function closeRecipeModal() {
    document.getElementById('recipe-modal').classList.add('hidden');
}
let tempIngredients = [];
function renderIngredientsEditor(ingredients) {
    tempIngredients = [...ingredients];
    const container = document.getElementById('ingredients-list');
    container.innerHTML = tempIngredients.map((ing, index) => `
        <div class="ingredient-item">
            <input type="text" placeholder="${t('itemName', 'Item name')}" value="${ing.item || ''}" onchange="updateIngredient(${index}, 'item', this.value)" data-ingredient-input="${index}">
            <button type="button" class="item-browse-btn" data-ingredient-browse="${index}" style="width:34px;height:34px;flex-shrink:0;"><i data-lucide="search" class="w-3.5 h-3.5"></i></button>
            <input type="number" placeholder="${t('amount', 'Amount')}" value="${ing.amount || 1}" min="1" onchange="updateIngredient(${index}, 'amount', this.value)">
            <button onclick="removeIngredient(${index})"><i data-lucide="x" class="w-4 h-4"></i></button>
        </div>
    `).join('');
    lucide.createIcons();
    container.querySelectorAll('input[data-ingredient-input]').forEach(input => {
        const idx = parseInt(input.dataset.ingredientInput);
        attachItemAutocomplete(input, (itemName) => {
            updateIngredient(idx, 'item', itemName);
        });
    });
}
function addIngredient() {
    tempIngredients.push({ item: '', amount: 1 });
    renderIngredientsEditor(tempIngredients);
}
function updateIngredient(index, field, value) {
    if (field === 'amount') value = parseInt(value) || 1;
    tempIngredients[index][field] = value;
}
function removeIngredient(index) {
    tempIngredients.splice(index, 1);
    renderIngredientsEditor(tempIngredients);
}
function saveRecipe() {
    const indexStr = document.getElementById('edit-recipe-index').value;
    const name = document.getElementById('recipe-input-name').value.trim();
    const label = document.getElementById('recipe-input-label').value.trim();
    if (!name || !label) {
        showAlert(t('enterRecipeName', 'Please enter a recipe name'));
        return;
    }
    const blueprint = readBlueprintInputs('recipe');
    if (blueprint === false) return;
    const recipe = {
        name: name,
        label: label,
        ingredients: tempIngredients.filter(i => i.item),
        result: {
            item: document.getElementById('recipe-result-item').value.trim(),
            amount: parseInt(document.getElementById('recipe-result-amount').value) || 1
        },
        craftTime: parseInt(document.getElementById('recipe-craft-time').value) || 5000,
        requiredLevel: parseInt(document.getElementById('recipe-required-level').value) || 1,
        xpReward: parseInt(document.getElementById('recipe-xp-reward').value) || 10,
        failChance: parseInt(document.getElementById('recipe-fail-chance').value) || 10,
        skillCheck: document.getElementById('recipe-skill-check').checked
    };
    if (blueprint) recipe.blueprint = blueprint;
    if (indexStr !== '') {
        currentRecipes[parseInt(indexStr)] = recipe;
    } else {
        currentRecipes.push(recipe);
    }
    closeRecipeModal();
    renderRecipesEditor();
}
function editRecipe(index) {
    openRecipeModal(currentRecipes[index], index);
}
function deleteRecipe(index) {
    showDeleteModal(t('confirmDeleteMsg', 'Are you sure you want to delete this?'), () => {
        currentRecipes.splice(index, 1);
        renderRecipesEditor();
    });
}
function switchModalTab(tabId) {
    document.querySelectorAll('.modal-tab').forEach(tab => {
        tab.classList.toggle('active', tab.dataset.modalTab === tabId);
    });
    document.querySelectorAll('.modal-tab-content').forEach(content => {
        content.classList.toggle('active', content.id === `modal-tab-${tabId}`);
    });
}
function showDeleteModal(message, callback) {
    getElement('delete-message').textContent = message;
    deleteCallback = callback;
    const modal = getElement('delete-modal');
    showModal(modal);
}
function confirmDelete() {
    if (deleteCallback) deleteCallback();
    closeDeleteModal();
}
function closeDeleteModal() {
    const modal = getElement('delete-modal');
    hideModal(modal, () => {
        deleteCallback = null;
    });
}
let selectedRecipeIndex = null;
let benchSearchTerm = '';
let isBenchCrafting = false;

function openBench(data) {
    isBenchOpen = true;
    currentBench = data.bench;
    playerXP = data.playerXP || { xp: 0 };
    playerXP.level = data.playerLevel || 1;
    if (data.config && data.config.oxInventory) {
        oxInventoryConfig = data.config.oxInventory;
    }
    if (data.config && data.config.itemImagePath) {
        customItemImagePath = data.config.itemImagePath;
    }
    if (data.locale) {
        locale = data.locale;
    }
    selectedRecipeIndex = null;
    benchSearchTerm = '';
    isBenchCrafting = false;

    translateStaticElements();

    const benchApp = getElement('bench-app');
    benchApp.classList.remove('hidden');

    const titleText = document.getElementById('bench-title-text');
    if (titleText) titleText.textContent = currentBench?.name || t('craftingTable', 'Crafting Table');

    const levelBadge = document.getElementById('bench-player-level');
    if (levelBadge) levelBadge.textContent = `${t('yourLevel', 'Your Level')}: ${playerXP.level || 1}`;

    const searchInput = document.getElementById('bench-search-input');
    if (searchInput) {
        searchInput.value = '';
        const newSearchInput = searchInput.cloneNode(true);
        searchInput.parentNode.replaceChild(newSearchInput, searchInput);
        newSearchInput.addEventListener('input', (e) => {
            benchSearchTerm = e.target.value;
            renderBenchRecipesGrid();
            lucide.createIcons();
        });
    }

    renderBenchRecipesGrid();
    lucide.createIcons();
}

function closeBench() {
    isBenchOpen = false;
    currentBench = null;
    selectedRecipeIndex = null;
    benchSearchTerm = '';

    const benchApp = getElement('bench-app');
    benchApp.classList.add('hidden');

    sendToLua('closeBench', {});
}

function getMaterialIcon(materialName) {
    const name = (materialName || '').toLowerCase();
    if (name.includes('iron') || name.includes('steel') || name.includes('metal')) return 'hammer';
    if (name.includes('copper') || name.includes('wire') || name.includes('electric')) return 'zap';
    if (name.includes('wood') || name.includes('plastic')) return 'box';
    return 'box';
}

function renderBenchRecipesGrid() {
    const container = document.getElementById('bench-recipes-grid');
    if (!container) return;

    const recipes = currentBench?.recipes || [];
    const term = benchSearchTerm.toLowerCase();

    const filteredRecipes = recipes.filter(recipe =>
        !term || (recipe.label || recipe.name || '').toLowerCase().includes(term)
    );

    const recipesHtml = filteredRecipes.map((recipe, index) => {
        const globalIndex = recipes.indexOf(recipe);
        const resultItem = recipe.result?.item || recipe.name;
        const resultImage = getItemImagePath(resultItem);
        const outputAmount = recipe.result?.amount || 1;
        const requiredLevel = recipe.requiredLevel || 1;
        const xpReward = recipe.xpReward || 0;
        const ingredients = recipe.ingredients || [];

        const materialsHtml = ingredients.map(ing => {
            const ingImage = getItemImagePath(ing.item);
            return `
                <div class="bench-recipe-material">
                    <div class="bench-recipe-material-left">
                        <img src="${ingImage}" alt="${ing.item}" class="bench-recipe-material-img" onerror="this.style.display='none'">
                        ${ing.item}
                    </div>
                    <div class="bench-recipe-material-amount has-enough">${ing.amount}</div>
                </div>
            `;
        }).join('');

        const tooltipHtml = ingredients.length > 0 ? `
            <div class="bench-recipe-materials-tooltip">
                <div class="bench-recipe-materials-tooltip-title">${t('ingredients', 'Required Materials')}</div>
                <div class="bench-recipe-materials-tooltip-list">
                    ${ingredients.map(ing => {
                        const ingImage = getItemImagePath(ing.item);
                        return `
                            <div class="bench-recipe-tooltip-material">
                                <img src="${ingImage}" alt="${ing.item}" class="bench-recipe-tooltip-img" onerror="this.style.display='none'">
                                <span class="bench-recipe-tooltip-name">${ing.item}</span>
                                <span class="bench-recipe-tooltip-amount">${ing.amount}</span>
                            </div>
                        `;
                    }).join('')}
                </div>
            </div>
        ` : '';

        const hasOverflow = ingredients.length > 3;

        return `
            <div class="bench-recipe-card" onclick="craftBenchRecipe(${globalIndex})">
                <div class="bench-recipe-image-box">
                    <img src="${resultImage}" alt="${recipe.label || recipe.name}" class="bench-recipe-image" onerror="this.style.opacity='0.3'">
                    <div class="bench-recipe-yield">x${outputAmount}</div>
                </div>
                <div class="bench-recipe-content">
                    <div class="bench-recipe-header-row">
                        <div>
                            <h3 class="bench-recipe-name">${recipe.label || recipe.name}</h3>
                            <p class="bench-recipe-level">${t('requiredLevel', 'Required Level')} ${requiredLevel}</p>
                        </div>
                        <div class="bench-recipe-xp">${xpReward}</div>
                    </div>
                    <div class="bench-recipe-materials-wrapper${hasOverflow ? ' has-overflow' : ''}">
                        <div class="bench-recipe-materials">
                            ${materialsHtml}
                        </div>
                        ${tooltipHtml}
                    </div>
                </div>
            </div>
        `;
    }).join('');

    container.innerHTML = recipesHtml;
}

window.craftBenchRecipe = function(index) {
    if (isBenchCrafting) return;

    selectedRecipeIndex = index;
    const recipes = currentBench?.recipes || [];
    const recipe = recipes[index];

    if (recipe) {
        isBenchCrafting = true;
        sendToLua('craftItem', { recipeIndex: index + 1 });
    }
};

function selectBenchRecipe(index) {
    selectedRecipeIndex = index;
    const recipes = currentBench?.recipes || [];
    const recipe = recipes[index];
    if (recipe) {
        sendToLua('selectItem', { item: recipe.result?.item || recipe.name });
    }
}

function craftSelectedItem() {
    if (selectedRecipeIndex === null || isBenchCrafting) return;
    isBenchCrafting = true;
    sendToLua('craftItem', { recipeIndex: selectedRecipeIndex + 1 });
}

function hideBenchForCrafting() {
    document.getElementById('bench-app').classList.add('hidden');
}

function updateXPDisplay() {
}

function renderRecipesList() {
    const container = document.getElementById('recipes-list');
    const allRecipes = currentBench?.recipes || [];
    const recipes = allRecipes.filter(r =>
        !benchSearchQuery ||
        (r.label || r.name || '').toLowerCase().includes(benchSearchQuery.toLowerCase())
    );
    if (recipes.length === 0) {
        container.innerHTML = `
            <div class="col-span-3 flex flex-col items-center justify-center py-12 text-center">
                <div class="w-12 h-12 rounded-xl bg-white/5 flex items-center justify-center mb-3 border border-white/[0.06]">
                    <i data-lucide="package-x" class="w-6 h-6 text-gray-600"></i>
                </div>
                <p class="text-gray-500 text-sm">${benchSearchQuery ? t('noRecipesFound', 'No recipes found') : t('noRecipes', 'No recipes available')}</p>
            </div>
        `;
        lucide.createIcons();
        return;
    }
    container.innerHTML = recipes.map((recipe, index) => {
        const actualIndex = allRecipes.indexOf(recipe);
        const isLocked = (recipe.requiredLevel || 1) > playerXP.level;
        const resultItem = recipe.result?.item || recipe.name;
        const resultImage = getItemImagePath(resultItem);
        const xpReward = recipe.xpReward || 0;
        const ingredients = recipe.ingredients || [];
        const ingredientsHtml = ingredients.slice(0, 4).map(ing => {
            const ingImage = getItemImagePath(ing.item);
            return `<div class="flex items-center gap-1" title="${ing.item}">
                <img src="${ingImage}" alt="${ing.item}" class="w-4 h-4 object-contain" onerror="this.style.opacity='0.3'">
                <span class="text-gray-500 text-[10px]">${ing.amount}x</span>
            </div>`;
        }).join('');
        const moreIngredients = ingredients.length > 4 ? `<span class="text-gray-600 text-[10px]">+${ingredients.length - 4}</span>` : '';
        return `
            <div class="recipe-card-item bg-[#111111] hover:bg-[#161616] border border-white/[0.04] hover:border-white/[0.08] rounded-xl p-3 cursor-pointer ${isLocked ? 'opacity-40' : ''}" onclick="${isLocked ? '' : `selectRecipe(${actualIndex})`}">
                <div class="flex items-center justify-between mb-2">
                    <span class="text-white text-xs font-semibold truncate pr-2">${recipe.label || recipe.name}</span>
                    ${isLocked ? '<i data-lucide="lock" class="w-3 h-3 text-red-400/60 shrink-0"></i>' : ''}
                </div>
                <div class="w-full h-[70px] bg-[#0a0a0a] rounded-lg flex items-center justify-center mb-2 border border-white/[0.02] overflow-hidden">
                    <img src="${resultImage}" alt="${resultItem}" class="max-w-[55px] max-h-[55px] object-contain" onerror="this.style.opacity='0.2'">
                </div>
                <div class="flex items-center justify-between text-[11px] mb-2">
                    <span class="text-gray-400 font-medium">${recipe.result?.amount || 1}x</span>
                    <span class="text-gray-500">${xpReward} xp</span>
                </div>
                <div class="pt-2 border-t border-white/[0.04]">
                    <div class="text-gray-600 text-[9px] uppercase tracking-wider mb-1.5">Required</div>
                    <div class="flex flex-wrap gap-2 items-center">
                        ${ingredientsHtml}
                        ${moreIngredients}
                    </div>
                </div>
            </div>
        `;
    }).join('');
    lucide.createIcons();
}
function selectRecipe(index) {
    sendToLua('selectRecipe', { recipeIndex: index + 1 });
}
function startCraftingAnimation(data) {
    const overlay = document.getElementById('crafting-overlay');
    const progressBar = document.getElementById('crafting-progress-bar');
    const timeDisplay = document.getElementById('crafting-time');
    const itemNameEl = document.getElementById('crafting-item-name');
    overlay.classList.remove('hidden');
    progressBar.style.width = '0%';
    if (itemNameEl && data.recipe) {
        itemNameEl.textContent = data.recipe.label || data.recipe.name || 'Item';
    }
    const duration = data.craftTime || 5000;
    const startTime = Date.now();
    const updateProgress = () => {
        const elapsed = Date.now() - startTime;
        const progress = Math.min(100, (elapsed / duration) * 100);
        const remaining = Math.max(0, (duration - elapsed) / 1000).toFixed(1);
        progressBar.style.width = progress + '%';
        timeDisplay.textContent = remaining + 's';
        if (elapsed < duration) {
            requestAnimationFrame(updateProgress);
        }
    };
    requestAnimationFrame(updateProgress);
}
function craftComplete(success, data) {
    isBenchCrafting = false;
    renderBenchRecipesGrid();
    lucide.createIcons();
}
function craftRejected(data) {
    isBenchCrafting = false;
    renderBenchRecipesGrid();
    lucide.createIcons();
}

function hideCraftingOverlay() {
    isBenchCrafting = false;
    renderBenchAssembly();
    lucide.createIcons();
}
function showSimpleSkillCheck(data) {
}
function updateSkillCheck(position) {
}
function hideSkillCheck(success) {
}
function handlePropPlacerComplete(data) {
    document.getElementById('creator-app').style.opacity = '1';
    document.getElementById('creator-app').style.pointerEvents = 'auto';
    document.getElementById('bench-modal').style.opacity = '1';
    document.getElementById('bench-modal').style.pointerEvents = 'auto';
    if (data.success && data.coords) {
        document.getElementById('bench-input-x').value = data.coords.x.toFixed(2);
        document.getElementById('bench-input-y').value = data.coords.y.toFixed(2);
        document.getElementById('bench-input-z').value = data.coords.z.toFixed(2);
        document.getElementById('bench-input-heading').value = Math.round(data.coords.heading);
        document.getElementById('heading-value').textContent = Math.round(data.coords.heading);
    }
}
function initializeEventListeners() {
    document.getElementById('craftButton')?.addEventListener('click', craftSelectedItem);
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && isBenchOpen && !isBenchAnimating) {
            closeBench();
        }
    });
    document.querySelectorAll('.modal-tab').forEach(tab => {
        tab.addEventListener('click', () => switchModalTab(tab.dataset.modalTab));
    });
    document.getElementById('bench-modal-cancel')?.addEventListener('click', closeBenchModal);
    document.getElementById('bench-modal-save')?.addEventListener('click', saveBench);
    document.getElementById('recipe-modal-cancel')?.addEventListener('click', closeRecipeModal);
    document.getElementById('recipe-modal-save')?.addEventListener('click', saveRecipe);
    document.getElementById('delete-cancel')?.addEventListener('click', closeDeleteModal);
    document.getElementById('delete-confirm')?.addEventListener('click', confirmDelete);
    document.getElementById('get-current-coords')?.addEventListener('click', () => {
        sendToLua('getCurrentCoords', {});
        setTimeout(() => {
            document.getElementById('bench-input-x').value = playerCoords.x.toFixed(2);
            document.getElementById('bench-input-y').value = playerCoords.y.toFixed(2);
            document.getElementById('bench-input-z').value = playerCoords.z.toFixed(2);
        }, 100);
    });
    document.getElementById('start-prop-placer')?.addEventListener('click', () => {
        const propSelector = document.getElementById('prop-model-selector');
        const selectedModel = propSelector?.dataset.value || 'workbench';
        const existingX = parseFloat(document.getElementById('bench-input-x').value) || 0;
        const existingY = parseFloat(document.getElementById('bench-input-y').value) || 0;
        const existingZ = parseFloat(document.getElementById('bench-input-z').value) || 0;
        const existingHeading = parseFloat(document.getElementById('bench-input-heading').value) || 0;
        document.getElementById('bench-modal').style.opacity = '0';
        document.getElementById('bench-modal').style.pointerEvents = 'none';
        sendToLua('startPropPlacer', {
            model: selectedModel,
            coords: { x: existingX, y: existingY, z: existingZ },
            heading: existingHeading
        });
    });
    document.getElementById('bench-input-heading')?.addEventListener('input', (e) => {
        document.getElementById('heading-value').textContent = e.target.value;
    });
    document.getElementById('add-recipe-btn')?.addEventListener('click', () => openRecipeModal());
    document.getElementById('add-ingredient-btn')?.addEventListener('click', addIngredient);
    document.getElementById('add-job-btn')?.addEventListener('click', addJob);
    document.getElementById('add-gang-btn')?.addEventListener('click', addGang);
    document.getElementById('groups-input')?.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            addGroup(e.target.value.trim());
            e.target.value = '';
        }
    });
    document.getElementById('discord-input')?.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            const input = document.getElementById('discord-input');
            const value = input.value.trim();
            if (value) {
                addDiscordRole(value);
                input.value = '';
            }
        }
    });
    document.getElementById('add-discord-btn')?.addEventListener('click', () => {
        const input = document.getElementById('discord-input');
        const value = input.value.trim();
        if (value) {
            addDiscordRole(value);
            input.value = '';
        }
    });
    document.getElementById('custom-alert-ok')?.addEventListener('click', closeAlert);
    document.getElementById('prop-model-selector')?.addEventListener('click', openPropModelModal);
    document.getElementById('prop-model-close')?.addEventListener('click', closePropModelModal);
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            if (document.getElementById('custom-alert-modal')?.classList.contains('hidden') === false) {
                closeAlert();
            } else if (document.getElementById('prop-model-modal')?.classList.contains('hidden') === false) {
                closePropModelModal();
            } else if (document.getElementById('recipe-modal')?.classList.contains('hidden') === false) {
                closeRecipeModal();
            } else if (document.getElementById('bench-modal')?.classList.contains('hidden') === false) {
                closeBenchModal();
            } else if (document.getElementById('delete-modal')?.classList.contains('hidden') === false) {
                closeDeleteModal();
            } else if (isBenchOpen) {
                closeBench();
            } else if (isCreatorOpen) {
                closeCreator();
            }
        }
    });
}
function openPropModelModal() {
    const modal = document.getElementById('prop-model-modal');
    const grid = document.getElementById('prop-model-grid');
    const currentValue = document.getElementById('prop-model-selector').dataset.value || 'workbench';
    grid.innerHTML = Object.entries(propModels).map(([key, value]) => {
        const isSelected = key === currentValue;
        const modelName = value.model || '';
        const imageUrl = value.image || '';
        return `
            <div class="prop-model-item ${isSelected ? 'selected' : ''}" data-value="${key}">
                <div class="prop-model-image-container">
                    ${imageUrl ? `<img src="${imageUrl}" alt="${value.label}" onerror="this.parentElement.innerHTML='<div class=\\'prop-model-no-image\\'><i data-lucide=\\'box\\' class=\\'w-8 h-8\\'></i></div>'" />` : `<div class="prop-model-no-image"><i data-lucide="box" class="w-8 h-8"></i></div>`}
                </div>
                <div class="prop-model-label">${value.label}</div>
                <div class="prop-model-name">${modelName || 'No prop'}</div>
            </div>
        `;
    }).join('');
    modal.classList.remove('hidden');
    lucide.createIcons();
    grid.querySelectorAll('.prop-model-item').forEach(item => {
        item.addEventListener('click', () => selectPropModel(item.dataset.value));
    });
}
function closePropModelModal() {
    document.getElementById('prop-model-modal').classList.add('hidden');
}
function selectPropModel(value) {
    const selector = document.getElementById('prop-model-selector');
    const textSpan = document.getElementById('prop-model-selected-text');
    const modelData = propModels[value];
    if (modelData) {
        selector.dataset.value = value;
        textSpan.textContent = modelData.label;
    }
    closePropModelModal();
}
function setPropModelValue(value) {
    const selector = document.getElementById('prop-model-selector');
    const textSpan = document.getElementById('prop-model-selected-text');
    const modelData = propModels[value];
    if (selector && modelData) {
        selector.dataset.value = value;
        textSpan.textContent = modelData.label;
    }
}

let activeAutocompleteId = 0;
function attachItemAutocomplete(input, onSelect) {
    if (input.dataset.autocompleteAttached) return;
    input.dataset.autocompleteAttached = 'true';
    const id = ++activeAutocompleteId;
    const wrapper = document.createElement('div');
    wrapper.className = 'item-autocomplete-wrapper';
    input.parentNode.insertBefore(wrapper, input);
    wrapper.appendChild(input);
    const dropdown = document.createElement('div');
    dropdown.className = 'item-autocomplete-dropdown';
    dropdown.id = 'item-ac-' + id;
    wrapper.appendChild(dropdown);

    let selectedIdx = -1;

    function renderDropdown(query) {
        if (!query || query.length < 1 || allInventoryItemsList.length === 0) {
            dropdown.classList.remove('open');
            return;
        }
        const q = query.toLowerCase();
        const matches = allInventoryItemsList.filter(item =>
            item.name.toLowerCase().includes(q) || (item.label || '').toLowerCase().includes(q)
        ).slice(0, 20);
        if (matches.length === 0) {
            dropdown.innerHTML = '<div class="item-autocomplete-empty">No items found</div>';
            dropdown.classList.add('open');
            selectedIdx = -1;
            return;
        }
        selectedIdx = -1;
        dropdown.innerHTML = matches.map((item, i) => {
            const imgPath = getItemImagePath(item.name);
            const weightText = item.weight ? ((item.weight / 1000).toFixed(2) + ' kg') : '';
            return `<div class="item-autocomplete-option" data-item-name="${item.name}" data-index="${i}">
                <img src="${imgPath}" alt="${item.name}" class="item-autocomplete-img" onerror="this.style.opacity='0.2'">
                <div class="item-autocomplete-info">
                    <div class="item-autocomplete-label">${item.label || item.name}</div>
                    <div class="item-autocomplete-name">${item.name}</div>
                </div>
                ${weightText ? `<div class="item-autocomplete-weight">${weightText}</div>` : ''}
            </div>`;
        }).join('');
        dropdown.classList.add('open');
        dropdown.querySelectorAll('.item-autocomplete-option').forEach(opt => {
            opt.addEventListener('mousedown', (e) => {
                e.preventDefault();
                const itemName = opt.dataset.itemName;
                const itemData = allInventoryItems[itemName];
                input.value = itemName;
                dropdown.classList.remove('open');
                if (onSelect) onSelect(itemName, itemData);
            });
        });
    }

    function highlightOption(idx) {
        const opts = dropdown.querySelectorAll('.item-autocomplete-option');
        opts.forEach((o, i) => {
            o.style.background = i === idx ? 'rgba(255,255,255,0.08)' : '';
        });
    }

    input.addEventListener('input', () => renderDropdown(input.value));
    input.addEventListener('focus', () => { if (input.value) renderDropdown(input.value); });
    input.addEventListener('blur', () => { setTimeout(() => dropdown.classList.remove('open'), 150); });
    input.addEventListener('keydown', (e) => {
        const opts = dropdown.querySelectorAll('.item-autocomplete-option');
        if (!dropdown.classList.contains('open') || opts.length === 0) return;
        if (e.key === 'ArrowDown') {
            e.preventDefault();
            selectedIdx = Math.min(selectedIdx + 1, opts.length - 1);
            highlightOption(selectedIdx);
            opts[selectedIdx]?.scrollIntoView({ block: 'nearest' });
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            selectedIdx = Math.max(selectedIdx - 1, 0);
            highlightOption(selectedIdx);
            opts[selectedIdx]?.scrollIntoView({ block: 'nearest' });
        } else if (e.key === 'Enter' && selectedIdx >= 0) {
            e.preventDefault();
            const opt = opts[selectedIdx];
            if (opt) {
                const itemName = opt.dataset.itemName;
                const itemData = allInventoryItems[itemName];
                input.value = itemName;
                dropdown.classList.remove('open');
                if (onSelect) onSelect(itemName, itemData);
            }
        } else if (e.key === 'Escape') {
            dropdown.classList.remove('open');
        }
    });
}

function attachAutocompletesToRecipeModal() {
    const nameInput = document.getElementById('recipe-input-name');
    const resultInput = document.getElementById('recipe-result-item');
    const blueprintInput = document.getElementById('recipe-blueprint-item');
    if (nameInput) {
        attachItemAutocomplete(nameInput, (itemName, itemData) => {
            const labelInput = document.getElementById('recipe-input-label');
            if (labelInput && !labelInput.value && itemData) {
                labelInput.value = itemData.label || itemName;
            }
            if (resultInput && !resultInput.value) {
                resultInput.value = itemName;
            }
        });
    }
    if (resultInput) {
        attachItemAutocomplete(resultInput);
    }
    if (blueprintInput) {
        attachItemAutocomplete(blueprintInput);
    }
}

function attachAutocompletesToGroupRecipeModal() {
    const nameInput = document.getElementById('group-recipe-input-name');
    const resultInput = document.getElementById('group-recipe-result-item');
    const blueprintInput = document.getElementById('group-recipe-blueprint-item');
    if (nameInput) {
        attachItemAutocomplete(nameInput, (itemName, itemData) => {
            const labelInput = document.getElementById('group-recipe-input-label');
            if (labelInput && !labelInput.value && itemData) {
                labelInput.value = itemData.label || itemName;
            }
            if (resultInput && !resultInput.value) {
                resultInput.value = itemName;
            }
        });
    }
    if (resultInput) {
        attachItemAutocomplete(resultInput);
    }
    if (blueprintInput) {
        attachItemAutocomplete(blueprintInput);
    }
}

function attachAutocompleteToIngredientInput(input) {
    attachItemAutocomplete(input);
}

let itemBrowserCallback = null;

function openItemBrowser(callback) {
    itemBrowserCallback = callback;
    const modal = document.getElementById('item-browser-modal');
    const search = document.getElementById('item-browser-search');
    const countEl = document.getElementById('item-browser-count');
    if (!modal) return;
    modal.classList.remove('hidden');
    if (countEl) countEl.textContent = allInventoryItemsList.length + ' items available';
    if (search) {
        search.value = '';
        setTimeout(() => search.focus(), 50);
    }
    renderItemBrowserGrid('');
    lucide.createIcons();
}

function closeItemBrowser() {
    const modal = document.getElementById('item-browser-modal');
    if (modal) modal.classList.add('hidden');
    itemBrowserCallback = null;
}

function renderItemBrowserGrid(query) {
    const grid = document.getElementById('item-browser-grid');
    if (!grid) return;
    const q = (query || '').toLowerCase().trim();
    const items = q
        ? allInventoryItemsList.filter(item =>
            item.name.toLowerCase().includes(q) || (item.label || '').toLowerCase().includes(q)
        )
        : allInventoryItemsList;
    const display = items.slice(0, 100);
    if (display.length === 0) {
        grid.innerHTML = '<div class="item-browser-empty">No items found</div>';
        return;
    }
    grid.innerHTML = display.map(item => {
        const imgPath = getItemImagePath(item.name);
        return `<div class="item-browser-card" data-item-name="${item.name}">
            <img src="${imgPath}" alt="${item.name}" class="item-browser-card-img" onerror="this.style.opacity='0.2'">
            <div class="item-browser-card-label">${item.label || item.name}</div>
            <div class="item-browser-card-name">${item.name}</div>
        </div>`;
    }).join('');
    grid.querySelectorAll('.item-browser-card').forEach(card => {
        card.addEventListener('click', () => {
            const itemName = card.dataset.itemName;
            const itemData = allInventoryItems[itemName];
            if (itemBrowserCallback) itemBrowserCallback(itemName, itemData);
            closeItemBrowser();
        });
    });
}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('item-browser-close')?.addEventListener('click', closeItemBrowser);
    document.getElementById('item-browser-search')?.addEventListener('input', debounce(function() {
        renderItemBrowserGrid(this.value);
    }, 150));
    document.getElementById('item-browser-modal')?.addEventListener('click', function(e) {
        if (e.target === this) closeItemBrowser();
    });

    document.getElementById('creator-app')?.addEventListener('click', function(e) {
        const btn = e.target.closest('.item-browse-btn');
        if (!btn) return;
        const targetId = btn.dataset.browseTarget;
        const ingredientIdx = btn.dataset.ingredientBrowse;
        const groupIngredientIdx = btn.dataset.groupIngredientBrowse;

        let input = null;
        if (targetId) {
            input = document.getElementById(targetId);
        } else {
            input = btn.parentElement?.querySelector('input[type="text"]') ||
                    btn.previousElementSibling;
        }
        if (!input) return;

        openItemBrowser((itemName, itemData) => {
            input.value = itemName;
            input.dispatchEvent(new Event('change', { bubbles: true }));

            if (ingredientIdx !== undefined) {
                updateIngredient(parseInt(ingredientIdx), 'item', itemName);
            }
            if (groupIngredientIdx !== undefined) {
                updateGroupIngredient(parseInt(groupIngredientIdx), 'item', itemName);
            }

            if (targetId === 'recipe-input-name' && itemData) {
                const labelInput = document.getElementById('recipe-input-label');
                if (labelInput && !labelInput.value) labelInput.value = itemData.label || itemName;
                const resultInput = document.getElementById('recipe-result-item');
                if (resultInput && !resultInput.value) resultInput.value = itemName;
            }
            if (targetId === 'group-recipe-input-name' && itemData) {
                const labelInput = document.getElementById('group-recipe-input-label');
                if (labelInput && !labelInput.value) labelInput.value = itemData.label || itemName;
                const resultInput = document.getElementById('group-recipe-result-item');
                if (resultInput && !resultInput.value) resultInput.value = itemName;
            }
        });
    });
});
