let backgroundMusic;

// Full state — populated from server via xpUpdate
let xpState = {
    xp: 0,
    level: 1,
    title: 'Fresh Kicks',
    multiplier: 1.0,
    nextLevelXP: 150,
    currentLevelXP: 0,
    maxLevel: false,
    recipes: [],       // annotated with locked:true/false by server
    craftingTable: 1,  // which bench is open (1 or 2)
};

// ─── Message bus ────────────────────────────────────────────────────────────

window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'openMenu') {
        document.body.style.display = 'flex';
        document.getElementById('menu-container').style.display = 'flex';
        document.getElementById('crafting-container').style.display = 'none';
        createMenu(data.items);
        if (data.playMusic) playBackgroundMusic(data.volume);

    } else if (data.action === 'closeMenu') {
        document.getElementById('menu-container').style.display = 'none';
        stopBackgroundMusic();
        if (document.getElementById('crafting-container').style.display === 'none') {
            document.body.style.display = 'none';
        }

    } else if (data.action === 'openCrafting') {
        document.body.style.display = 'flex';
        document.getElementById('crafting-container').style.display = 'flex';
        document.getElementById('menu-container').style.display = 'none';
        // Store which table is open so craft buttons post the right table number
        xpState.craftingTable = data.craftingTable || 1;

        // Table 2 = crafting only — hide XP strip, progress button, more info
        var isTable2 = xpState.craftingTable === 2;
        document.getElementById('xp-bar-strip').style.display      = isTable2 ? 'none' : '';
        document.getElementById('more-info-button').style.display   = isTable2 ? 'none' : '';

        // Recipes arrive moments later via xpUpdate — render with current state
        createCraftingMenu(xpState.recipes, xpState.craftingTable);
        if (data.playMusic) playBackgroundMusic(data.volume);

    } else if (data.action === 'closeCrafting') {
        document.getElementById('crafting-container').style.display = 'none';
        document.getElementById('xp-modal-overlay').style.display = 'none';
        stopBackgroundMusic();
        if (document.getElementById('menu-container').style.display === 'none') {
            document.body.style.display = 'none';
        }

    } else if (data.action === 'notify') {
        showNotification(data.message, data.type);

    } else if (data.action === 'xpUpdate') {
        handleXPUpdate(data.xpData);
    }
});

// ─── NUI fetch helper ────────────────────────────────────────────────────────

function nuiPost(endpoint, payload, cb) {
    fetch(`https://${GetParentResourceName()}/${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(payload || {})
    }).then(r => r.json()).then(cb || (() => {})).catch(console.error);
}

// ─── Close buttons ──────────────────────────────────────────────────────────

document.getElementById('close-button').addEventListener('click', function() {
    nuiPost('close', {}, function() {
        document.getElementById('menu-container').style.display = 'none';
        stopBackgroundMusic();
        if (document.getElementById('crafting-container').style.display === 'none') {
            document.body.style.display = 'none';
        }
    });
});

document.getElementById('close-crafting-button').addEventListener('click', function() {
    nuiPost('closeCrafting', {}, function() {
        document.getElementById('crafting-container').style.display = 'none';
        document.getElementById('xp-modal-overlay').style.display = 'none';
        stopBackgroundMusic();
        if (document.getElementById('menu-container').style.display === 'none') {
            document.body.style.display = 'none';
        }
    });
});

// ─── Purchase menu builder ───────────────────────────────────────────────────

function createMenu(items) {
    const menu = document.getElementById('menu');
    menu.innerHTML = '';
    items.forEach(item => {
        const menuItem = document.createElement('div');
        menuItem.className = 'menu-item';
        menuItem.id = item.id;

        const itemImg = document.createElement('img');
        itemImg.src = item.img;
        itemImg.alt = item.name;

        const itemName = document.createElement('span');
        itemName.innerText = item.name;

        const itemPrice = document.createElement('span');
        itemPrice.className = 'item-price';
        itemPrice.innerText = `$${item.price}`;

        const quantityInput = document.createElement('input');
        quantityInput.type = 'number';
        quantityInput.min = '1';
        quantityInput.value = '1';

        const purchaseButton = document.createElement('button');
        purchaseButton.innerText = 'Purchase';
        purchaseButton.addEventListener('click', function() {
            new Audio('sounds/click.mp3').play();
            nuiPost('purchase', { id: item.id, quantity: quantityInput.value });
        });

        menuItem.append(itemImg, itemName, itemPrice, quantityInput, purchaseButton);
        menu.appendChild(menuItem);
    });
}

// ─── Crafting menu builder ───────────────────────────────────────────────────
// craftingTable (1 or 2) is embedded in every craft button payload so the NUI
// callback routes to the correct server-side recipe list.

function createCraftingMenu(recipes, craftingTable) {
    const tbl = craftingTable || xpState.craftingTable || 1;
    const craftingMenu = document.getElementById('crafting-menu');
    craftingMenu.innerHTML = '';

    if (!recipes || recipes.length === 0) return;

    recipes.forEach(recipe => {
        const isLocked = recipe.locked === true;

        const craftingItem = document.createElement('div');
        craftingItem.className = 'crafting-item' + (isLocked ? ' crafting-item--locked' : '');
        craftingItem.dataset.recipeId = recipe.id;

        const itemImg = document.createElement('img');
        itemImg.src = recipe.img;
        itemImg.alt = recipe.name;

        const itemName = document.createElement('span');
        itemName.innerText = recipe.name.replace(/_/g, ' ');

        if (isLocked) {
            const lockOverlay = document.createElement('div');
            lockOverlay.className = 'lock-overlay';
            lockOverlay.innerHTML =
                '<i class="fas fa-lock lock-icon"></i>' +
                '<span class="lock-label">Unlocks at Level ' + recipe.unlockLevel + '</span>';
            craftingItem.append(itemImg, itemName, lockOverlay);
        } else {
            const requiredItems = document.createElement('div');
            requiredItems.className = 'required-items';
            recipe.requiredItems.forEach(req => {
                const div = document.createElement('div');
                div.innerText = req.quantity + 'x ' + req.id.replace(/_/g, ' ');
                requiredItems.appendChild(div);
            });

            const craftButton = document.createElement('button');
            craftButton.innerText = 'Craft';
            craftButton.addEventListener('click', (function(rid, t) {
                return function() {
                    new Audio('sounds/click.mp3').play();
                    nuiPost('craft', { id: rid, craftingTable: t });
                };
            }(recipe.id, tbl)));

            craftingItem.append(itemImg, itemName, requiredItems, craftButton);
        }

        craftingMenu.appendChild(craftingItem);
    });
}

// ─── XP update handler ──────────────────────────────────────────────────────

function handleXPUpdate(data) {
    // Preserve the active table if the server did not echo it back
    const activeTbl = data.craftingTable || xpState.craftingTable || 1;
    xpState = Object.assign({}, xpState, data, { craftingTable: activeTbl });

    updateXPStrip(xpState);

    // Re-render crafting menu whenever recipe lock states may have changed
    if (document.getElementById('crafting-container').style.display !== 'none') {
        createCraftingMenu(xpState.recipes, activeTbl);
    }

    if (document.getElementById('xp-modal-overlay').style.display !== 'none') {
        updateXPModal(xpState);
    }

    // Flash the strip on XP gain (suppress on initial load)
    if (!data.leveledUp) {
        var strip = document.getElementById('xp-bar-strip');
        strip.classList.remove('xp-flash');
        void strip.offsetWidth;
        strip.classList.add('xp-flash');
    }
}

function updateXPStrip(data) {
    document.getElementById('xp-strip-level').textContent = data.level;
    document.getElementById('xp-strip-title').textContent = data.title;

    var pct = 0;
    if (!data.maxLevel && data.nextLevelXP && data.nextLevelXP > data.currentLevelXP) {
        var progress = data.xp - data.currentLevelXP;
        var needed   = data.nextLevelXP - data.currentLevelXP;
        pct = Math.min(100, Math.floor((progress / needed) * 100));
        document.getElementById('xp-strip-label').textContent =
            data.xp.toLocaleString() + ' / ' + data.nextLevelXP.toLocaleString() + ' XP';
    } else {
        pct = 100;
        document.getElementById('xp-strip-label').textContent = 'MAX LEVEL';
    }
    document.getElementById('xp-strip-fill').style.width = pct + '%';
}

// ─── XP Modal ───────────────────────────────────────────────────────────────

document.getElementById('xp-panel-open-btn').addEventListener('click', function() {
    if (xpState.craftingTable === 2) return;
    document.getElementById('xp-modal-overlay').style.display = 'flex';
    updateXPModal(xpState);
    buildRoadmap();
});

document.getElementById('close-xp-modal').addEventListener('click', function() {
    document.getElementById('xp-modal-overlay').style.display = 'none';
});

document.getElementById('xp-modal-overlay').addEventListener('click', function(e) {
    if (e.target === this) this.style.display = 'none';
});

function updateXPModal(data) {
    document.getElementById('xp-modal-level-num').textContent = data.level;
    document.getElementById('xp-modal-rank-title').textContent = data.title;

    var bonusPct = Math.round((data.multiplier - 1) * 100);
    document.getElementById('xp-modal-multiplier-val').textContent = '+' + bonusPct + '%';
    document.getElementById('xp-modal-current-xp').textContent = data.xp.toLocaleString() + ' XP total';

    var pct = 0;
    if (!data.maxLevel && data.nextLevelXP) {
        var progress = data.xp - data.currentLevelXP;
        var needed   = data.nextLevelXP - data.currentLevelXP;
        pct = Math.min(100, Math.floor((progress / needed) * 100));
        document.getElementById('xp-modal-next-level-label').textContent =
            'Next level: ' + data.nextLevelXP.toLocaleString() + ' XP';
    } else {
        pct = 100;
        document.getElementById('xp-modal-next-level-label').textContent = '\u2756 Legendary Cobbler \u2014 MAX LEVEL';
    }
    document.getElementById('xp-modal-bar-fill').style.width = pct + '%';
}

// Builds the level roadmap. Recipe unlocks shown are from whichever table is
// currently open in xpState so the player sees contextually relevant callouts.
function buildRoadmap() {
    var list = document.getElementById('xp-roadmap-list');
    list.innerHTML = '';

    var levels = [
        { level: 1,  xpRequired: 0,    multiplier: 1.00, title: 'Fresh Kicks'      },
        { level: 2,  xpRequired: 150,  multiplier: 1.05, title: 'Apprentice'        },
        { level: 3,  xpRequired: 400,  multiplier: 1.10, title: 'Sneaker Worker'    },
        { level: 4,  xpRequired: 800,  multiplier: 1.15, title: 'Sneaker Hustler'   },
        { level: 5,  xpRequired: 1400, multiplier: 1.20, title: 'Seasoned Seller'   },
        { level: 6,  xpRequired: 2200, multiplier: 1.28, title: 'Kicks Dealer'      },
        { level: 7,  xpRequired: 3200, multiplier: 1.36, title: 'Kicks Boss'        },
        { level: 8,  xpRequired: 4500, multiplier: 1.45, title: 'Sole Mogul'        },
        { level: 9,  xpRequired: 6000, multiplier: 1.55, title: 'Sole Supplier'     },
        { level: 10, xpRequired: 8000, multiplier: 1.70, title: 'Legendary Cobbler' },
    ];

    var recipesByLevel = {};
    (xpState.recipes || []).forEach(function(r) {
        var ul = r.unlockLevel || 1;
        if (ul > 1) {
            if (!recipesByLevel[ul]) recipesByLevel[ul] = [];
            recipesByLevel[ul].push(r.name);
        }
    });

    levels.forEach(function(lvl) {
        var row = document.createElement('div');
        row.className = 'roadmap-row' + (lvl.level === xpState.level ? ' roadmap-current' : '');
        if (xpState.xp >= lvl.xpRequired) row.classList.add('roadmap-unlocked');

        var bonusPct  = Math.round((lvl.multiplier - 1) * 100);
        var unlocks   = recipesByLevel[lvl.level];
        var unlockTag = unlocks
            ? '<span class="roadmap-unlock-tag">\uD83D\uDC9F Unlocks: ' + unlocks.join(', ') + '</span>'
            : '';

        row.innerHTML =
            '<div class="roadmap-badge">LVL ' + lvl.level + '</div>' +
            '<div class="roadmap-details">' +
                '<span class="roadmap-title">' + lvl.title + '</span>' +
                '<span class="roadmap-xp">' + lvl.xpRequired.toLocaleString() + ' XP required</span>' +
                unlockTag +
            '</div>' +
            '<div class="roadmap-bonus' + (bonusPct > 0 ? ' bonus-positive' : '') + '">+' + bonusPct + '% payout</div>';

        list.appendChild(row);
    });
}

// ─── Info panel ─────────────────────────────────────────────────────────────

document.getElementById('more-info-button').addEventListener('click', function() {
    document.getElementById('info-container').style.display = 'flex';
    document.getElementById('crafting-container').style.display = 'none';
});

document.getElementById('close-info-button').addEventListener('click', function() {
    document.getElementById('info-container').style.display = 'none';
    document.getElementById('crafting-container').style.display = 'flex';
});

// ─── Notifications ──────────────────────────────────────────────────────────

function showNotification(message, type) {
    var container = document.getElementById('notification-container');
    var notification = document.createElement('div');
    notification.className = 'notification ' + type;
    notification.innerText = message;
    container.appendChild(notification);
    setTimeout(function() { notification.remove(); }, 4000);
}

// ─── Music ──────────────────────────────────────────────────────────────────

function playBackgroundMusic(volume) {
    backgroundMusic = new Audio('sounds/background.mp3');
    backgroundMusic.loop   = true;
    backgroundMusic.volume = volume;
    backgroundMusic.play();
}

function stopBackgroundMusic() {
    if (backgroundMusic) {
        backgroundMusic.pause();
        backgroundMusic.currentTime = 0;
        backgroundMusic = null;
    }
}
