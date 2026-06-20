const app = document.getElementById('app');
const outfitList = document.getElementById('outfit-list');
const countSpan = document.getElementById('count');
const maxCountSpan = document.getElementById('max-count');
const inputModal = document.getElementById('input-modal');
const nameInput = document.getElementById('outfit-name-input');
const selectedOutfitName = document.getElementById('selected-outfit-name');
const modalTitle = document.getElementById('modal-title');


let currentLocales = {};
let maxOutfits = 5;
let selectedIndex = -1;
let isOwner = true;
let isReadOnly = false;
let isLocked = false;
let modalMode = 'create';
let editIndex = -1;

function applyLocales() {
    const l = currentLocales;
    if (!l) return;
    if (unzipBtn) unzipBtn.innerHTML = `<i class="fas fa-lock-open"></i> ${l.ui_open_bag || 'OPEN'}`;
    if (selectedOutfitName) selectedOutfitName.innerText = l.ui_select_outfit || 'Select Outfit';

    const ts = document.getElementById('timestamp');
    if (ts) ts.innerText = l.ui_saved_recently || 'Saved recently';

    const wearSpan = document.querySelector('#btn-wear span');
    if (wearSpan) wearSpan.innerText = l.ui_apply || 'APPLY';

    const renameSpan = document.querySelector('#btn-rename span');
    if (renameSpan) renameSpan.innerText = l.ui_edit || 'EDIT';

    const deleteSpan = document.querySelector('#btn-delete span');
    if (deleteSpan) deleteSpan.innerText = l.ui_delete || 'DELETE';

    const btnMask = document.getElementById('btn-part-mask');
    if (btnMask) btnMask.title = l.ui_equip_mask || 'Equip Mask Only';

    const btnTop = document.getElementById('btn-part-top');
    if (btnTop) btnTop.title = l.ui_equip_top || 'Equip Top Only';

    const btnPants = document.getElementById('btn-part-pants');
    if (btnPants) btnPants.title = l.ui_equip_pants || 'Equip Pants Only';

    const btnShoes = document.getElementById('btn-part-shoes');
    if (btnShoes) btnShoes.title = l.ui_equip_shoes || 'Equip Shoes Only';

    if (saveBtn) saveBtn.innerText = l.ui_save_current || 'SAVE CURRENT OUTFIT';

    if (modalTitle && modalMode === 'create') modalTitle.innerText = l.ui_name_outfit || 'Name Your Outfit';
    if (modalTitle && modalMode === 'edit') modalTitle.innerText = l.ui_edit_outfit || 'Edit Outfit';

    if (nameInput) nameInput.placeholder = l.ui_outfit_name || 'Outfit Name';

    const catLabel = document.querySelector('.category-label');
    if (catLabel) catLabel.innerText = l.ui_category || 'Category';

    const mCancel = document.getElementById('modal-cancel');
    if (mCancel) mCancel.innerText = l.ui_cancel || 'CANCEL';

    const mConfirm = document.getElementById('modal-confirm');
    if (mConfirm) mConfirm.innerText = l.ui_confirm || 'CONFIRM';
}

const closedState = document.getElementById('closed-state');
const openPanel = document.getElementById('open-panel');
const unzipBtn = document.getElementById('btn-unzip');
const deleteBtn = document.getElementById('btn-delete');
const renameBtn = document.getElementById('btn-rename');
const saveBtn = document.getElementById('btn-save');
const lockBtn = document.getElementById('btn-lock');

function updateLockUI() {
    if (!lockBtn) return;
    lockBtn.style.display = isOwner ? 'flex' : 'none';
    const icon = lockBtn.querySelector('i');
    if (icon) {
        icon.className = isLocked ? 'fas fa-lock' : 'fas fa-lock-open';
        lockBtn.style.color = isLocked ? '#ff4444' : '#ccc';
    }
}

if (lockBtn) {
    lockBtn.onclick = () => {
        isLocked = !isLocked;
        updateLockUI();
        fetch(`https://mi-outfitbag/toggleLock`, {
            method: 'POST',
            body: JSON.stringify({ locked: isLocked })
        });
    };
}

window.addEventListener('message', (event) => {
    const data = event.data;
    if (data.action === 'open') {
        app.style.display = 'flex';
        app.classList.add('ui-open');

        if (closedState && openPanel && !data.skipReset) {
            closedState.style.display = 'flex';
            openPanel.style.display = 'none';
        }


        currentOutfits = data.outfits || [];
        maxOutfits = data.max;
        if (typeof data.isOwner === 'boolean') {
            isOwner = data.isOwner;
        } else {
            isOwner = true;
        }
        if (typeof data.isReadOnly === 'boolean') {
            isReadOnly = data.isReadOnly;
        } else {
            isReadOnly = false;
        }

        if (typeof data.isLocked === 'boolean') {
            isLocked = data.isLocked;
        } else {
            isLocked = false;
        }

        if (data.locales) {
            currentLocales = data.locales;
            applyLocales();
        }

        updateLockUI();

        if (maxCountSpan) maxCountSpan.innerText = maxOutfits;

        renderOutfits();
    }
    else if (data.action === 'close') {
        app.style.display = 'none';
        app.classList.remove('ui-open');
        inputModal.style.display = 'none';
        selectedIndex = -1;
        isOwner = true;
        isReadOnly = false;
        modalMode = 'create';
        editIndex = -1;
    }
});

if (unzipBtn) {
    unzipBtn.onclick = () => {
        if (isLocked && !isOwner) {
            const icon = unzipBtn.querySelector('i');
            if (icon) {
                icon.className = 'fas fa-lock';
                setTimeout(() => icon.className = 'fas fa-lock-open', 1000);
            }
            return;
        }
        closedState.style.display = 'none';
        openPanel.style.display = 'flex';

        if (selectedIndex === -1 && currentOutfits.length > 0) {
            selectedIndex = 0;
            triggerPreview(0);
        }
        renderOutfits();
    };
}

function renderOutfits() {
    outfitList.innerHTML = '';
    if (countSpan) countSpan.innerText = currentOutfits.length;

    currentOutfits.forEach((outfit, index) => {
        const item = document.createElement('div');
        const catClass = outfit.category ? `cat-${outfit.category}` : '';
        item.className = `outfit-item ${index === selectedIndex ? 'active' : ''} ${catClass}`;
        item.onclick = () => selectOutfit(index);

        const icons = {
            'work': 'fa-briefcase',
            'casual': 'fa-tshirt',
            'heist': 'fa-mask',
            'formal': 'fa-user-tie',
            'party': 'fa-glass-cheers'
        };
        const iconClass = (outfit.category && icons[outfit.category]) ? icons[outfit.category] : 'fa-tshirt';

        item.innerHTML = `
            <div class="slot-icon">
                <i class="fas ${iconClass}"></i>
            </div>
            <div class="outfit-info">
                <div class="outfit-name">${outfit.label}</div>
                <div class="outfit-details">${currentLocales.ui_outfit_slot || 'OUTFIT'} ${index + 1}</div>
            </div>
            <div class="select-badge">
                ${index === selectedIndex ? (currentLocales.ui_selected || 'SELECTED') : (currentLocales.ui_select || 'SELECT')}
            </div>
        `;
        outfitList.appendChild(item);
    });

    if (selectedOutfitName) {
        if (selectedIndex !== -1 && currentOutfits[selectedIndex]) {
            selectedOutfitName.innerText = currentOutfits[selectedIndex].label;
        } else {
            selectedOutfitName.innerText = currentLocales.ui_select_outfit || "Select Outfit";
        }
    }

    updateOwnerState();
}

function updateOwnerState() {
    const canEdit = isOwner && !isReadOnly;
    if (saveBtn) saveBtn.disabled = !canEdit;
    if (deleteBtn) deleteBtn.disabled = !canEdit || selectedIndex === -1;
    if (renameBtn) renameBtn.disabled = !canEdit || selectedIndex === -1;
}

function selectOutfit(index) {
    if (selectedIndex === index) return;
    selectedIndex = index;
    renderOutfits();
    triggerPreview(index);
}

function triggerPreview(index) {
    fetch(`https://mi-outfitbag/previewOutfit`, {
        method: 'POST',
        body: JSON.stringify({ index: index })
    });
}

document.getElementById('btn-wear').onclick = () => {
    if (selectedIndex === -1) return;
    fetch(`https://mi-outfitbag/wearOutfit`, {
        method: 'POST',
        body: JSON.stringify({ index: selectedIndex })
    });
};



if (deleteBtn) {
    deleteBtn.onclick = () => {
        if (!isOwner || isReadOnly || selectedIndex === -1) return;
        fetch(`https://mi-outfitbag/deleteOutfit`, {
            method: 'POST',
            body: JSON.stringify({ index: selectedIndex })
        });
    };
}

if (renameBtn) {
    renameBtn.onclick = () => {
        if (!isOwner || isReadOnly || selectedIndex === -1) return;
        const outfit = currentOutfits[selectedIndex];
        if (!outfit) return;

        modalMode = 'edit';
        editIndex = selectedIndex;
        if (modalTitle) modalTitle.innerText = currentLocales.ui_edit_outfit || 'Edit Outfit';
        inputModal.style.display = 'flex';
        nameInput.value = outfit.label || '';
        setSelectedCategory(outfit.category || 'casual');
        nameInput.focus();
    };
}

const parts = ['mask', 'top', 'pants', 'shoes'];
parts.forEach(part => {
    const btn = document.getElementById(`btn-part-${part}`);
    if (btn) {
        btn.onclick = () => {
            if (selectedIndex === -1) return;
            fetch(`https://mi-outfitbag/applyPart`, {
                method: 'POST',
                body: JSON.stringify({
                    index: selectedIndex,
                    part: part
                })
            });
        };
    }
});

const catBtns = document.querySelectorAll('.cat-btn');
let selectedCategory = 'casual';

function setSelectedCategory(cat) {
    selectedCategory = cat || 'casual';
    catBtns.forEach(b => b.classList.toggle('selected', b.dataset.cat === selectedCategory));
}

catBtns.forEach(btn => {
    btn.onclick = () => {
        setSelectedCategory(btn.dataset.cat);
    };
});

if (saveBtn) {
    saveBtn.onclick = () => {
        if (!isOwner || isReadOnly) return;
        modalMode = 'create';
        editIndex = -1;
        if (modalTitle) modalTitle.innerText = currentLocales.ui_name_outfit || 'Name Your Outfit';
        inputModal.style.display = 'flex';
        nameInput.value = '';

        setSelectedCategory('casual');

        nameInput.focus();
    };
}

document.getElementById('modal-cancel').onclick = () => {
    inputModal.style.display = 'none';
    modalMode = 'create';
    editIndex = -1;
    if (modalTitle) modalTitle.innerText = currentLocales.ui_name_outfit || 'Name Your Outfit';
};

document.getElementById('modal-confirm').onclick = () => {
    const name = nameInput.value.trim();
    if (!name) return;

    inputModal.style.display = 'none';
    if (modalMode === 'edit') {
        if (editIndex === -1) return;
        fetch(`https://mi-outfitbag/renameOutfit`, {
            method: 'POST',
            body: JSON.stringify({
                index: editIndex,
                name: name,
                category: selectedCategory
            })
        });
    } else {
        fetch(`https://mi-outfitbag/saveOutfit`, {
            method: 'POST',
            body: JSON.stringify({
                name: name,
                category: selectedCategory
            })
        });
    }
    modalMode = 'create';
    editIndex = -1;
    if (modalTitle) modalTitle.innerText = currentLocales.ui_name_outfit || 'Name Your Outfit';
};

document.getElementById('btn-close').onclick = () => {
    fetch(`https://mi-outfitbag/close`, { method: 'POST' });
};

document.onkeyup = function (data) {
    if (data.which == 27) {
        fetch(`https://mi-outfitbag/close`, { method: 'POST' });
    }
};
const previewContainer = document.querySelector('.preview-container');
let isDragging = false;

if (previewContainer) {
    previewContainer.onmousedown = (e) => {
        isDragging = true;
    };

    window.onmouseup = () => {
        isDragging = false;
    };

    window.onmousemove = (e) => {
        if (!isDragging) return;

        const delta = e.movementX * 2.5;

        fetch(`https://mi-outfitbag/rotatePreview`, {
            method: 'POST',
            body: JSON.stringify({ delta: delta })
        });
    };
}
