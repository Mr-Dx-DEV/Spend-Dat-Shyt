let backgroundMusic;

// Full state — populated from server via xpUpdate
let xpState = {
    xp: 0,
    level: 1,
    title: 'First Boot',
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
        showCraftingTab();
        stopBackgroundMusic();
        if (document.getElementById('menu-container').style.display === 'none') {
            document.body.style.display = 'none';
        }

    } else if (data.action === 'notify') {
        showNotification(data.message, data.type);

    } else if (data.action === 'xpUpdate') {
        handleXPUpdate(data.xpData);

    } else if (data.action === 'openConsole') {
        openConsoleModal(data.payload);
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
        showCraftingTab();
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

    if (document.getElementById('xp-panel').style.display !== 'none') {
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

// ─── XP Inline Panel ────────────────────────────────────────────────────────

function showXPTab() {
    document.getElementById('crafting-menu').style.display    = 'none';
    document.getElementById('more-info-button').style.display = 'none';
    var panel = document.getElementById('xp-panel');
    panel.style.display = 'flex';
    // restart enter animation cleanly even if reopened
    panel.classList.remove('xp-panel-in');
    void panel.offsetWidth;
    panel.classList.add('xp-panel-in');
}

function showCraftingTab() {
    document.getElementById('xp-panel').style.display = 'none';
    document.getElementById('crafting-menu').style.display = '';
    // Only restore More Info on table 1 (table 2 hides it entirely)
    if (xpState.craftingTable !== 2) {
        document.getElementById('more-info-button').style.display = '';
    }
}

document.getElementById('xp-panel-open-btn').addEventListener('click', function() {
    if (xpState.craftingTable === 2) return;
    updateXPModal(xpState);
    buildRoadmap();
    showXPTab();
});

document.getElementById('xp-panel-back-btn').addEventListener('click', showCraftingTab);

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
        document.getElementById('xp-modal-next-level-label').textContent = '\u2756 Console Legend \u2014 MAX LEVEL';
    }
    document.getElementById('xp-modal-bar-fill').style.width = pct + '%';
}

// Builds the level roadmap. Recipe unlocks shown are from whichever table is
// currently open in xpState so the player sees contextually relevant callouts.
function buildRoadmap() {
    var list = document.getElementById('xp-roadmap-list');
    list.innerHTML = '';

    var levels = [
        { level: 1,  xpRequired: 0,    multiplier: 1.00, title: 'First Boot'          },
        { level: 2,  xpRequired: 150,  multiplier: 1.05, title: 'Console Rookie'      },
        { level: 3,  xpRequired: 400,  multiplier: 1.10, title: 'Tech Apprentice'     },
        { level: 4,  xpRequired: 800,  multiplier: 1.15, title: 'Console Flipper'     },
        { level: 5,  xpRequired: 1400, multiplier: 1.20, title: 'System Specialist'   },
        { level: 6,  xpRequired: 2200, multiplier: 1.28, title: 'Hardware Dealer'     },
        { level: 7,  xpRequired: 3200, multiplier: 1.36, title: 'Console Boss'        },
        { level: 8,  xpRequired: 4500, multiplier: 1.45, title: 'Game System Mogul'   },
        { level: 9,  xpRequired: 6000, multiplier: 1.55, title: 'TechWorkz Supplier'  },
        { level: 10, xpRequired: 8000, multiplier: 1.70, title: 'Console Legend'      },
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
// ─── Console Inspect / Box Modal ────────────────────────────────────────────
// Lightweight: no library, no polling. Server sends a single payload with
// {item, boxedItem, name, img, condition, tierId, tierLabel, colourVar} and
// the modal renders it. The Box button posts back; the server reconciles
// against its single-use token.

(function () {
    const root  = document.getElementById('console-modal-root');
    if (!root) return; // markup not present, bail out cleanly

    const modal       = document.getElementById('console-modal');
    const closeBtn    = document.getElementById('console-close-btn');
    const nameEl      = document.getElementById('console-modal-name');
    const imgEl       = document.getElementById('console-image');
    const glowEl      = document.getElementById('console-image-glow');
    const gaugeFill   = document.getElementById('console-gauge-fill');
    const ticksGroup  = document.getElementById('console-gauge-ticks');
    const valueEl     = document.getElementById('console-condition-value');
    const tierEl      = document.getElementById('console-condition-tier');
    const boxBtn      = document.getElementById('console-box-btn');
    const boxBtnLabel = boxBtn.querySelector('span');
    const boxHint     = document.getElementById('console-box-hint');
    const reqWrap     = document.getElementById('console-requirements');
    const reqRow      = reqWrap.querySelector('.console-req-row');
    const reqImg      = document.getElementById('console-req-img');
    const reqName     = document.getElementById('console-req-name');
    const reqHave     = document.getElementById('console-req-have');

    // Pre-render tick marks once. The arc spans 180° from (20,100) to (180,100)
    // around center (100,100). 11 ticks at every 10% feels diagnostic without
    // being noisy.
    const TICK_COUNT = 11;
    const arcRadius  = 80;
    const cx = 100, cy = 100;
    const innerR = arcRadius - 4, outerR = arcRadius + 4;
    for (let i = 0; i < TICK_COUNT; i++) {
        const t = i / (TICK_COUNT - 1);                  // 0..1
        const angle = Math.PI - (Math.PI * t);           // π..0  (left → right)
        const x1 = cx + Math.cos(angle) * innerR;
        const y1 = cy - Math.sin(angle) * innerR;
        const x2 = cx + Math.cos(angle) * outerR;
        const y2 = cy - Math.sin(angle) * outerR;
        const line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
        line.setAttribute('x1', x1.toFixed(2));
        line.setAttribute('y1', y1.toFixed(2));
        line.setAttribute('x2', x2.toFixed(2));
        line.setAttribute('y2', y2.toFixed(2));
        ticksGroup.appendChild(line);
    }

    // Arc length for a half-circle of radius 80 = π * 80 ≈ 251.327
    const ARC_LENGTH = Math.PI * arcRadius;

    let countAnimRaf = null;
    let isOpen = false;

    function setCondition(pct, colourVar) {
        // Resolve the CSS var on the element so currentColor (used by the
        // gauge glow) picks it up. Falling back to --accent keeps us safe
        // if the server sends an unknown var name.
        const safeVar = colourVar && /^--[\w-]+$/.test(colourVar) ? colourVar : '--accent';
        const resolved = getComputedStyle(document.documentElement)
            .getPropertyValue(safeVar).trim() || getComputedStyle(document.documentElement)
            .getPropertyValue('--accent').trim();
        gaugeFill.style.stroke = resolved;
        gaugeFill.style.color  = resolved; // for the drop-shadow currentColor
        tierEl.style.color     = resolved;

        // Stroke offset: full arc when 0%, no offset when 100%.
        const clamped = Math.max(0, Math.min(100, pct));
        const offset  = ARC_LENGTH * (1 - clamped / 100);
        // Reset to start then transition to the final offset on next frame so
        // reopening the modal animates again.
        gaugeFill.style.transition = 'none';
        gaugeFill.style.strokeDashoffset = ARC_LENGTH;
        // Force reflow then re-enable transition.
        void gaugeFill.getBoundingClientRect();
        gaugeFill.style.transition = '';
        gaugeFill.style.strokeDashoffset = offset;

        // Animate the number counting up in parallel with the arc.
        if (countAnimRaf) cancelAnimationFrame(countAnimRaf);
        const duration = 1100; // matches the arc transition
        const start = performance.now();
        const startVal = 0;
        const tick = (now) => {
            const elapsed = now - start;
            const p = Math.min(1, elapsed / duration);
            // Same ease as the arc (approx) — cubic-out
            const eased = 1 - Math.pow(1 - p, 3);
            const current = Math.round(startVal + (clamped - startVal) * eased);
            valueEl.textContent = current;
            if (p < 1) countAnimRaf = requestAnimationFrame(tick);
        };
        countAnimRaf = requestAnimationFrame(tick);
    }

    function openConsoleModal(payload) {
        if (!payload) return;
        isOpen = true;

        // The body is display:none by default and only the existing menus
        // unhide it. We need to do the same so the modal is actually visible.
        // We also explicitly hide every other top-level container — without
        // this, #menu-container (which has no inline display:none and defaults
        // to flex) renders its header/logo behind our modal scrim.
        document.body.style.display = 'flex';
        document.getElementById('menu-container').style.display     = 'none';
        document.getElementById('crafting-container').style.display = 'none';
        document.getElementById('info-container').style.display     = 'none';

        nameEl.textContent = payload.name || payload.item || 'Console';
        tierEl.textContent = payload.tierLabel || '—';
        imgEl.src   = payload.img || '';
        imgEl.alt   = payload.name || '';

        // Box requirement row: only shown when the server sends a boxItem.
        // Without one, this console doesn't need a box (legacy config shape).
        if (payload.boxItem) {
            reqWrap.hidden = false;
            reqName.textContent = payload.boxName || payload.boxItem;
            reqImg.src = payload.boxImg || '';
            reqImg.alt = payload.boxName || '';
            const have = Number(payload.boxCount) || 0;
            reqHave.textContent = have;
            const hasBox = have >= 1;
            reqRow.classList.toggle('missing', !hasBox);
            boxBtn.disabled = !hasBox;
            if (hasBox) {
                boxBtnLabel.textContent = 'Box for Sale';
                boxHint.textContent = 'Boxing locks in this condition and prepares the console for resale.';
            } else {
                boxBtnLabel.textContent = 'Missing Box';
                boxHint.textContent = 'You need the matching box for this console before you can box it.';
            }
        } else {
            reqWrap.hidden = true;
            reqRow.classList.remove('missing');
            boxBtn.disabled = false;
            boxBtnLabel.textContent = 'Box for Sale';
            boxHint.textContent = 'Boxing locks in this condition and prepares the console for resale.';
        }

        // Reset visual state before showing — handles rapid reopens.
        valueEl.textContent = '0';
        gaugeFill.style.strokeDashoffset = ARC_LENGTH;

        root.style.display = 'flex';
        root.setAttribute('aria-hidden', 'false');
        // Next frame so the .console-open class transition runs.
        requestAnimationFrame(() => {
            root.classList.add('console-open');
            // Tier colour + condition animate together. Slight delay so the
            // modal enter transition gets its own moment first.
            setTimeout(() => setCondition(payload.condition || 0, payload.colourVar), 80);

            // Tint the radial glow behind the console image with the tier colour.
            const resolved = getComputedStyle(document.documentElement)
                .getPropertyValue(payload.colourVar || '--accent').trim();
            if (resolved) {
                glowEl.style.background = `radial-gradient(circle, ${hexToRgba(resolved, 0.18)} 0%, transparent 70%)`;
            }
        });
    }

    function closeConsoleModal(viaBox) {
        if (!isOpen) return;
        isOpen = false;
        root.classList.remove('console-open');
        root.setAttribute('aria-hidden', 'true');
        // Wait for the exit transition before hiding from layout, then check
        // whether any other UI is still up. If not, hide the body too so we
        // don't leave an invisible-but-present element capturing focus.
        setTimeout(() => {
            root.style.display = 'none';
            const menuOpen     = document.getElementById('menu-container').style.display !== 'none'
                              && document.getElementById('menu-container').style.display !== '';
            const craftingOpen = document.getElementById('crafting-container').style.display !== 'none'
                              && document.getElementById('crafting-container').style.display !== '';
            const infoOpen     = document.getElementById('info-container').style.display !== 'none'
                              && document.getElementById('info-container').style.display !== '';
            if (!menuOpen && !craftingOpen && !infoOpen) {
                document.body.style.display = 'none';
            }
        }, 220);

        if (countAnimRaf) { cancelAnimationFrame(countAnimRaf); countAnimRaf = null; }

        nuiPost(viaBox ? 'boxConsole' : 'closeConsole', {});
    }

    // Convert "#rrggbb" or "rgb(...)" to an rgba with the given alpha.
    function hexToRgba(c, a) {
        c = c.trim();
        if (c.startsWith('#')) {
            const n = c.length === 4
                ? c.slice(1).split('').map(x => x + x).join('')
                : c.slice(1);
            const r = parseInt(n.slice(0, 2), 16);
            const g = parseInt(n.slice(2, 4), 16);
            const b = parseInt(n.slice(4, 6), 16);
            return `rgba(${r}, ${g}, ${b}, ${a})`;
        }
        const m = c.match(/rgba?\(([^)]+)\)/);
        if (m) {
            const parts = m[1].split(',').map(s => s.trim());
            return `rgba(${parts[0]}, ${parts[1]}, ${parts[2]}, ${a})`;
        }
        return c;
    }

    closeBtn.addEventListener('click', () => closeConsoleModal(false));
    document.getElementById('console-modal-scrim').addEventListener('click', () => closeConsoleModal(false));
    boxBtn.addEventListener('click', () => {
        if (boxBtn.disabled) return;
        boxBtn.disabled = true; // prevent double-click double-fire
        closeConsoleModal(true);
    });

    // Escape key closes (only when the modal is up — cheap guard, no listener
    // attach/detach churn).
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && isOpen) closeConsoleModal(false);
    });

    // Expose for the message handler.
    window.openConsoleModal = openConsoleModal;
})();
