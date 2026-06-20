// oxide-blackmarket Shop UI

// State
let currentTab = 'buy';
let shopData = null;
let localeStrings = {};

// DOM Elements
const shopContainer = document.getElementById('shop-container');
const buyInventory = document.getElementById('buy-inventory');
const sellInventory = document.getElementById('sell-inventory');
const tabBuy = document.getElementById('tab-buy');
const tabSell = document.getElementById('tab-sell');
const playerRep = document.getElementById('player-rep');
const playerCash = document.getElementById('player-cash');

// Format locale string with %s substitution
function formatLocale(str, ...args) {
    let i = 0;
    return str.replace(/%s/g, () => args[i++] ?? '');
}

// Apply locale strings to elements with data-locale attributes
function applyLocaleStrings() {
    document.querySelectorAll('[data-locale]').forEach(el => {
        const key = el.getAttribute('data-locale');
        if (localeStrings[key]) {
            el.textContent = localeStrings[key];
        }
    });
}

// Listen for messages from Lua
window.addEventListener('message', function(event) {
    const data = event.data;

    switch(data.action) {
        case 'openShop':
            if (data.locale) {
                localeStrings = data.locale;
                applyLocaleStrings();
            }
            openShop(data.data);
            break;
        case 'closeShop':
            closeShop();
            break;
        case 'updateCash':
            updateCash(data.cash);
            break;
        case 'updateStock':
            updateStock(data.item, data.stock);
            break;
        case 'updateSellInventory':
            renderSellInventory(data.sellInventory);
            break;
        case 'updateRep':
            updateRep(data.rep, data.tier, data.tierName);
            break;
    }
});

// Open shop with data
function openShop(data) {
    shopData = data;

    // Update player info
    if (data.enableTiers) {
        playerRep.textContent = `${data.tierName} (${data.playerRep})`;
        playerRep.style.display = '';
    } else {
        playerRep.textContent = '';
        playerRep.style.display = 'none';
    }
    playerCash.textContent = `$${formatNumber(data.playerCash)}`;

    // Render inventories
    renderBuyInventory(data.buyInventory);
    renderSellInventory(data.sellInventory);

    // Show container
    shopContainer.classList.remove('hidden');

    // Reset to buy tab
    switchTab('buy');
}

function closeShop() {
    shopContainer.classList.add('hidden');
    shopData = null;
}

// User-initiated close (ESC key or close button)
function requestClose() {
    closeShop();
    // Notify Lua to release focus and update state
    fetch('https://oxide-blackmarket/close', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
}

// Switch between buy/sell tabs
function switchTab(tab) {
    currentTab = tab;

    if (tab === 'buy') {
        tabBuy.classList.add('active');
        tabSell.classList.remove('active');
        buyInventory.classList.remove('hidden');
        sellInventory.classList.add('hidden');
    } else {
        tabBuy.classList.remove('active');
        tabSell.classList.add('active');
        buyInventory.classList.add('hidden');
        sellInventory.classList.remove('hidden');
    }
}

// Render buy inventory
function renderBuyInventory(items) {
    if (!items || items.length === 0) {
        const msg = localeStrings.no_items_at_level || 'No items available at your reputation level';
        buyInventory.innerHTML = `<div class="placeholder-message">${escapeHtml(msg)}</div>`;
        return;
    }

    buyInventory.innerHTML = '';
    items.forEach(item => {
        buyInventory.innerHTML += createItemRow(item, 'buy');
    });
}

// Render sell inventory
function renderSellInventory(items) {
    if (!items || items.length === 0) {
        const msg = localeStrings.no_items_to_sell || 'You have no items to sell';
        sellInventory.innerHTML = `<div class="placeholder-message">${escapeHtml(msg)}</div>`;
        return;
    }

    sellInventory.innerHTML = '';
    items.forEach(item => {
        sellInventory.innerHTML += createItemRow(item, 'sell');
    });
}

// Escape HTML to prevent XSS
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// Create item row HTML
function createItemRow(item, type) {
    const priceLabel = type === 'buy' ? `$${formatNumber(item.price)}` : `$${formatNumber(item.sellPrice)}`;
    const stockTemplate = type === 'buy' ? (localeStrings.stock || 'Stock: %s') : (localeStrings.have || 'Have: %s');
    const stockLabel = formatLocale(stockTemplate, type === 'buy' ? item.stock : item.count);
    const buttonLabel = type === 'buy' ? (localeStrings.buy || 'Buy') : (localeStrings.sell || 'Sell');
    const buttonAction = type === 'buy' ? `buyItem('${escapeHtml(item.item)}')` : `sellItem('${escapeHtml(item.item)}')`;
    const maxQty = type === 'buy' ? item.stock : item.count;
    const isDisabled = maxQty <= 0 ? 'disabled' : '';
    const rowClass = maxQty <= 0 ? 'item-row out-of-stock' : 'item-row';
    const safeItemName = escapeHtml(item.item);
    const safeLabel = escapeHtml(item.label);

    // Rep gain display for sell items (hidden when tiers disabled)
    let repGain = '';
    if (type === 'sell' && item.repGain && shopData && shopData.enableTiers) {
        const repTemplate = localeStrings.rep_gain || '+%s rep';
        repGain = `<div class="item-rep">${escapeHtml(formatLocale(repTemplate, item.repGain))}</div>`;
    }

    return `
        <div class="${rowClass}" data-item="${safeItemName}">
            <div class="item-icon">
                <img src="${escapeHtml(item.imagePath || '')}" onerror="this.style.display='none'" />
            </div>
            <div class="item-details">
                <div class="item-name">${safeLabel}</div>
                <div class="item-price">${priceLabel}</div>
                <div class="item-stock">${escapeHtml(stockLabel)}</div>
                ${repGain}
            </div>
            <div class="item-actions">
                <div class="qty-row">
                    <button class="qty-btn" onclick="adjustQty('${type}', '${safeItemName}', -1, ${maxQty})" ${isDisabled}>−</button>
                    <input type="number" class="qty-input" id="qty-${type}-${safeItemName}" value="1" min="1" max="${maxQty}" ${isDisabled} />
                    <button class="qty-btn" onclick="adjustQty('${type}', '${safeItemName}', 1, ${maxQty})" ${isDisabled}>+</button>
                </div>
                <button class="action-btn" onclick="${buttonAction}" ${isDisabled}>${escapeHtml(buttonLabel)}</button>
            </div>
        </div>
    `;
}

// Adjust quantity
function adjustQty(type, item, delta, max) {
    const input = document.getElementById(`qty-${type}-${item}`);
    if (!input) return;

    let value = parseInt(input.value) || 1;
    value = Math.max(1, Math.min(max, value + delta));
    input.value = value;
}

// Buy item
function buyItem(item) {
    const input = document.getElementById(`qty-buy-${item}`);
    const quantity = input ? parseInt(input.value) || 1 : 1;

    fetch('https://oxide-blackmarket/buy', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ item: item, quantity: quantity })
    });
}

// Sell item
function sellItem(item) {
    const input = document.getElementById(`qty-sell-${item}`);
    const quantity = input ? parseInt(input.value) || 1 : 1;

    fetch('https://oxide-blackmarket/sell', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ item: item, quantity: quantity })
    });
}

// Update cash display
function updateCash(cash) {
    playerCash.textContent = `$${formatNumber(cash)}`;
    if (shopData) shopData.playerCash = cash;
}

// Update reputation display
function updateRep(rep, tier, tierName) {
    if (shopData && !shopData.enableTiers) return;
    playerRep.textContent = `${tierName} (${rep})`;
    if (shopData) {
        shopData.playerRep = rep;
        shopData.playerTier = tier;
        shopData.tierName = tierName;
    }
}

// Update item stock (buy inventory only)
function updateStock(item, stock) {
    const row = buyInventory.querySelector(`.item-row[data-item="${CSS.escape(item)}"]`);
    if (!row) return;

    // Update stock text
    const stockDiv = row.querySelector('.item-stock');
    if (stockDiv) {
        const stockTemplate = localeStrings.stock || 'Stock: %s';
        stockDiv.textContent = formatLocale(stockTemplate, stock);
    }

    // Update max quantity
    const input = row.querySelector('.qty-input');
    if (input) {
        input.max = stock;
        if (parseInt(input.value) > stock) {
            input.value = Math.max(1, stock);
        }
    }

    // Handle out of stock
    if (stock <= 0) {
        row.classList.add('out-of-stock');
        row.querySelectorAll('button, input').forEach(el => el.disabled = true);
    } else {
        row.classList.remove('out-of-stock');
        row.querySelectorAll('button, input').forEach(el => el.disabled = false);
    }

    // Update local data
    if (shopData && shopData.buyInventory) {
        const itemData = shopData.buyInventory.find(i => i.item === item);
        if (itemData) itemData.stock = stock;
    }
}

// Format number with commas
function formatNumber(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// Listen for ESC key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        requestClose();
    }
});

// Tab click handlers
if (tabBuy) {
    tabBuy.addEventListener('click', function() {
        switchTab('buy');
    });
}

if (tabSell) {
    tabSell.addEventListener('click', function() {
        switchTab('sell');
    });
}

// Close button handler
const closeBtn = document.getElementById('close-btn');
if (closeBtn) {
    closeBtn.addEventListener('click', requestClose);
}
