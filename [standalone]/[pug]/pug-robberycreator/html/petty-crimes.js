(function () {
    let pettyCrimeUiState = {
        activePanel: 'objects',
        selectedObjectIndex: 0,
    };

    function escapePettyHtml(value) {
        return String(value ?? '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    function notifyPettyPreset(message, type = 'success') {
        $.post('https://' + GetParentResourceName() + '/NuiNotify', JSON.stringify({
            Notify: message,
            Type: type,
        }));
    }

    function normalizePettyPresetBaseName(raw) {
        return String(raw || '')
            .trim()
            .replace(/\.json$/i, '')
            .replace(/[<>:"/\\|?*]/g, '_')
            .replace(/\s+/g, '_')
            .replace(/_+/g, '_')
            .replace(/^_+|_+$/g, '');
    }

    function ensurePettyPresetModal() {
        let modal = document.getElementById('pettyCrimePresetFileModal');
        if (modal) return modal;

        modal = document.createElement('div');
        modal.id = 'pettyCrimePresetFileModal';
        modal.className = 'overlay rc-modal petty-preset-file-modal';
        modal.style.display = 'none';
        modal.innerHTML = `
            <div class="container rc-modal-card rc-import-card rc-preset-card petty-preset-file-card">
                <h2 id="pettyCrimePresetFileModalTitle">Petty Crime Preset</h2>
                <p id="pettyCrimePresetFileModalNote" class="rc-preset-note"></p>
                <div id="pettyCrimePresetFileSelectRow">
                    <label for="pettyCrimePresetFileSelect" class="rc-preset-label">Preset File</label>
                    <select id="pettyCrimePresetFileSelect"></select>
                </div>
                <div id="pettyCrimePresetFileInputRow">
                    <label for="pettyCrimePresetFileInput" class="rc-preset-label">Preset Name</label>
                    <input id="pettyCrimePresetFileInput" type="text" placeholder="petty-crime-setup" autocomplete="off">
                </div>
                <div class="rc-preset-actions">
                    <button id="pettyCrimePresetFileConfirmButton" type="button" class="save-banktruck-button">Continue</button>
                    <button id="pettyCrimePresetFileCancelButton" type="button" class="remove-target-button">Cancel</button>
                </div>
            </div>
        `;
        document.body.appendChild(modal);
        modal.addEventListener('click', (event) => {
            if (event.target === modal) closePettyPresetModal();
        });
        document.getElementById('pettyCrimePresetFileCancelButton')?.addEventListener('click', closePettyPresetModal);
        document.getElementById('pettyCrimePresetFileInput')?.addEventListener('keydown', (event) => {
            if (event.key === 'Enter') {
                event.preventDefault();
                document.getElementById('pettyCrimePresetFileConfirmButton')?.click();
            }
        });
        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape' && modal.style.display !== 'none') {
                closePettyPresetModal();
            }
        });
        return modal;
    }

    function closePettyPresetModal() {
        const modal = document.getElementById('pettyCrimePresetFileModal');
        if (modal) modal.style.display = 'none';
        const selectWrap = document.querySelector('#pettyCrimePresetFileSelect.pug-native-hidden + .pug-select');
        if (selectWrap) selectWrap.classList.remove('open');
    }

    async function fetchPettyPresetFiles() {
        const response = await fetch(`https://${GetParentResourceName()}/GetPettyCrimePresetFiles`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({}),
        });
        return response.json();
    }

    function getPettyPresetSelectItems() {
        const select = document.getElementById('pettyCrimePresetFileSelect');
        return Array.from(select?.options || []).map((option) => ({
            value: option.value,
            label: option.textContent || option.value,
        }));
    }

    function ensurePettyPresetDropdown() {
        const select = document.getElementById('pettyCrimePresetFileSelect');
        if (!select || typeof rcWrapSelectWithSearch !== 'function') return;

        rcWrapSelectWithSearch(select, {
            placeholder: 'Search petty crime preset...',
            populate: false,
            emptyLabel: 'Select petty crime preset',
            getItems: getPettyPresetSelectItems,
        });

        const selectWrap = document.querySelector('#pettyCrimePresetFileSelect.pug-native-hidden + .pug-select');
        if (selectWrap) selectWrap.classList.remove('open');
    }

    async function openPettyPresetModal(mode) {
        const modal = ensurePettyPresetModal();
        const title = document.getElementById('pettyCrimePresetFileModalTitle');
        const note = document.getElementById('pettyCrimePresetFileModalNote');
        const selectRow = document.getElementById('pettyCrimePresetFileSelectRow');
        const inputRow = document.getElementById('pettyCrimePresetFileInputRow');
        const select = document.getElementById('pettyCrimePresetFileSelect');
        const input = document.getElementById('pettyCrimePresetFileInput');
        const confirmButton = document.getElementById('pettyCrimePresetFileConfirmButton');

        if (!modal || !title || !note || !confirmButton) return;
        confirmButton.onclick = null;

        if (mode === 'load') {
            const result = await fetchPettyPresetFiles().catch(() => null);
            const files = Array.isArray(result?.files) ? result.files : [];
            if (!files.length) {
                notifyPettyPreset('No petty crime preset files were found.', 'error');
                return;
            }

            title.textContent = 'Load Petty Crime Preset';
            note.textContent = 'Choose a saved petty crime setup from preset-info/pettycrime-presets.';
            if (selectRow) selectRow.style.display = 'block';
            if (inputRow) inputRow.style.display = 'none';
            if (select) {
                select.innerHTML = '';
                files.forEach((fileName) => {
                    const option = document.createElement('option');
                    option.value = fileName;
                    option.textContent = fileName;
                    select.appendChild(option);
                });
                ensurePettyPresetDropdown();
                if (select.options.length) {
                    select.selectedIndex = 0;
                    select.dispatchEvent(new Event('change', { bubbles: true }));
                }
            }
            confirmButton.textContent = 'Load Preset';
            confirmButton.onclick = () => {
                const fileName = select?.value || '';
                if (!fileName) {
                    notifyPettyPreset('Select a petty crime preset file first.', 'error');
                    return;
                }
                closePettyPresetModal();
                loadPettyPreset(fileName);
            };
        } else {
            title.textContent = 'Save Petty Crime Preset';
            note.textContent = 'Save the current full petty crime setup into preset-info/pettycrime-presets.';
            if (selectRow) selectRow.style.display = 'none';
            if (inputRow) inputRow.style.display = 'block';
            if (input) input.value = '';
            const selectWrap = document.querySelector('#pettyCrimePresetFileSelect.pug-native-hidden + .pug-select');
            if (selectWrap) selectWrap.classList.remove('open');
            confirmButton.textContent = 'Save Preset';
            confirmButton.onclick = () => {
                const fileName = normalizePettyPresetBaseName(input?.value || '');
                if (!fileName) {
                    notifyPettyPreset('Enter a petty crime preset name first.', 'error');
                    return;
                }
                closePettyPresetModal();
                savePettyPreset(fileName);
            };
        }

        modal.style.display = 'flex';
        if (mode === 'save' && input) {
            requestAnimationFrame(() => {
                input.focus();
                input.select();
            });
        }
    }

    async function savePettyPreset(fileName) {
        savePettyObjectEditorToState();
        capturePettyPorchState();
        pettyCrimeData = normalizePettyCrimeData(pettyCrimeData);

        try {
            const response = await fetch(`https://${GetParentResourceName()}/SavePettyCrimePreset`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ fileName, data: pettyCrimeData }),
            });
            const result = await response.json();
            if (!result?.success) {
                notifyPettyPreset(result?.error || 'Failed to save petty crime preset.', 'error');
                return;
            }
            notifyPettyPreset(`Saved petty crime preset ${result.fileName || `${fileName}.json`}.`, 'success');
        } catch (error) {
            console.error('Error saving petty crime preset:', error);
            notifyPettyPreset('Failed to save petty crime preset.', 'error');
        }
    }

    async function loadPettyPreset(fileName) {
        try {
            const response = await fetch(`https://${GetParentResourceName()}/LoadPettyCrimePreset`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ fileName }),
            });
            const result = await response.json();
            if (!result?.success) {
                notifyPettyPreset(result?.error || 'Failed to load petty crime preset.', 'error');
                return;
            }
            pettyCrimeData = normalizePettyCrimeData(result.data || {});
            window.LoadPettyCrimeData(pettyCrimeData);
            window.SavePettyCrimeData();
            notifyPettyPreset(`Loaded petty crime preset ${result.fileName || fileName}.`, 'success');
        } catch (error) {
            console.error('Error loading petty crime preset:', error);
            notifyPettyPreset('Failed to load petty crime preset.', 'error');
        }
    }

    function getPettyCrimeDefaults() {
        const defaultPoliceJobs = Array.isArray(Config?.DefualPoliceJobs) ? Config.DefualPoliceJobs : [];
        const defaultObjects = Array.isArray(Config?.PettyCrimeObjectModels)
            ? Config.PettyCrimeObjectModels.map((entry) => ({
                label: entry.label || entry.model || 'Object',
                model: entry.model || '',
                models: entry.model ? [entry.model] : [],
                interactionLabel: `Rob ${entry.label || entry.model || 'Object'}`,
                progressLabel: `Searching ${(entry.label || entry.model || 'object').toLowerCase()}`,
                progressDuration: 7000,
                policeRequired: 0,
                alertChance: '100',
                cooldown: 15,
                minigameOption: 'none',
                sendAlert: false,
                policeAlertHeader: `${entry.label || entry.model || 'Object'} Being Robbed`,
                policeAlert: `${entry.label || entry.model || 'Object'} robbery in progress.`,
                policeJobs: [...defaultPoliceJobs],
                alertCode: '10-90',
                alertIcon: 'fas fa-bell',
                alertPriority: '2',
                alertCamId: '',
                blipSprite: '59',
                blipColor: '0',
                blipScale: '1.0',
                alertSound1: 'robberysound',
                blipFlash: false,
                moneyReward: false,
                rewardType: 'cash',
                minMoney: '25',
                maxMoney: '75',
                moneyChance: '100',
                rewardItems: [],
                requiredItems: [],
                moneyRewardEnabled: false,
                rewardItemsEnabled: false,
                requiredItemsEnabled: false,
                enabled: false,
            }))
            : [];

        return {
            objectRobberies: defaultObjects,
            porchPirate: {
                enabled: true,
                interactionLabel: 'Steal Package',
                progressLabel: 'Snatching package',
                progressDuration: 5000,
                policeRequired: 0,
                cooldown: 20,
                activeSpawnPercent: 25,
                minigameOption: 'none',
                moneyReward: false,
                rewardType: 'cash',
                minMoney: '50',
                maxMoney: '150',
                moneyChance: '100',
                rewardItems: [],
                requiredItems: [],
                moneyRewardEnabled: false,
                rewardItemsEnabled: false,
                requiredItemsEnabled: false,
                locations: [],
                activeLocationIds: [],
            },
        };
    }

    function normalizePettyCrimeModels(models, fallbackModel = '') {
        const normalized = [];
        const seen = new Set();

        const addModel = (model) => {
            const value = String(model || '').trim();
            if (!value || seen.has(value)) return;
            seen.add(value);
            normalized.push(value);
        };

        if (Array.isArray(models)) models.forEach(addModel);
        addModel(fallbackModel);
        return normalized;
    }

    function normalizePettyCrimeEntry(entry = {}, fallback = {}) {
        const models = normalizePettyCrimeModels(entry.models, entry.model || fallback.model || '');
        const model = models[0] || '';
        const label = String(entry.label || fallback.label || model || 'Object').trim();
        const rewardItems = Array.isArray(entry.rewardItems) ? entry.rewardItems : (Array.isArray(fallback.rewardItems) ? fallback.rewardItems : []);
        const requiredItems = Array.isArray(entry.requiredItems) ? entry.requiredItems : (Array.isArray(fallback.requiredItems) ? fallback.requiredItems : []);
        const hasRewardItems = rewardItems.some((item) => String(item?.itemName ?? item?.name ?? '').trim() !== '');
        const hasRequiredItems = requiredItems.some((item) => String(item?.itemName ?? item?.name ?? '').trim() !== '');
        const moneyRewardEnabled = !!(entry.moneyRewardEnabled ?? fallback.moneyRewardEnabled ?? entry.moneyReward ?? fallback.moneyReward);
        return {
            label,
            model,
            models,
            interactionLabel: String(entry.interactionLabel || fallback.interactionLabel || `Rob ${label}`),
            progressLabel: String(entry.progressLabel || fallback.progressLabel || `Searching ${label.toLowerCase()}`),
            progressDuration: Number(entry.progressDuration ?? fallback.progressDuration ?? 7000) || 7000,
            policeRequired: Number(entry.policeRequired ?? fallback.policeRequired ?? 0) || 0,
            alertChance: String(entry.alertChance ?? fallback.alertChance ?? '100'),
            cooldown: Number(entry.cooldown ?? fallback.cooldown ?? 15) || 0,
            minigameOption: String(entry.minigameOption || fallback.minigameOption || 'none'),
            sendAlert: entry.sendAlert ?? fallback.sendAlert ?? false,
            policeAlertHeader: String(entry.policeAlertHeader || fallback.policeAlertHeader || `${label} Being Robbed`),
            policeAlert: String(entry.policeAlert || fallback.policeAlert || `${label} robbery in progress.`),
            policeJobs: Array.isArray(entry.policeJobs) ? entry.policeJobs.map((job) => String(job || '').trim()).filter(Boolean) : (Array.isArray(fallback.policeJobs) ? fallback.policeJobs : []),
            alertCode: String(entry.alertCode || fallback.alertCode || '10-90'),
            alertIcon: String(entry.alertIcon || fallback.alertIcon || 'fas fa-bell'),
            alertPriority: String(entry.alertPriority || fallback.alertPriority || '2'),
            alertCamId: String(entry.alertCamId || fallback.alertCamId || ''),
            blipSprite: String(entry.blipSprite ?? fallback.blipSprite ?? '59'),
            blipColor: String(entry.blipColor ?? fallback.blipColor ?? '0'),
            blipScale: String(entry.blipScale ?? fallback.blipScale ?? '1.0'),
            alertSound1: String(entry.alertSound1 || fallback.alertSound1 || 'robberysound'),
            blipFlash: entry.blipFlash ?? fallback.blipFlash ?? false,
            moneyReward: moneyRewardEnabled,
            moneyRewardEnabled,
            rewardType: String(entry.rewardType || fallback.rewardType || 'cash'),
            minMoney: String(entry.minMoney ?? fallback.minMoney ?? '25'),
            maxMoney: String(entry.maxMoney ?? fallback.maxMoney ?? '75'),
            moneyChance: String(entry.moneyChance ?? fallback.moneyChance ?? '100'),
            rewardItems,
            requiredItems,
            rewardItemsEnabled: !!(entry.rewardItemsEnabled ?? fallback.rewardItemsEnabled ?? hasRewardItems) || hasRewardItems,
            requiredItemsEnabled: !!(entry.requiredItemsEnabled ?? fallback.requiredItemsEnabled ?? hasRequiredItems) || hasRequiredItems,
            enabled: entry.enabled ?? fallback.enabled ?? true,
        };
    }

    function normalizePettyCrimeLocation(location = {}, index = 0) {
        const coords = location.coords || location.position || {};
        const x = Number(coords.x ?? coords[0]);
        const y = Number(coords.y ?? coords[1]);
        const z = Number(coords.z ?? coords[2]);
        if (!Number.isFinite(x) || !Number.isFinite(y) || !Number.isFinite(z)) return null;

        return {
            id: String(location.id || `porch_${index + 1}`),
            label: String(location.label || `Package Spot ${index + 1}`),
            model: String(location.model || ''),
            heading: Number(location.heading ?? 0) || 0,
            coords: { x, y, z },
        };
    }

    function parsePettyCrimeInput(data) {
        if (typeof data === 'string') {
            const trimmed = data.trim();
            if (!trimmed) return {};

            try {
                const parsed = JSON.parse(trimmed);
                return parsed && typeof parsed === 'object' ? parsed : {};
            } catch (error) {
                console.error('Failed to parse petty crime data:', error);
                return {};
            }
        }

        return (data && typeof data === 'object') ? data : {};
    }

    function getPettyObjectRobberies() {
        return Array.isArray(pettyCrimeData?.objectRobberies) ? pettyCrimeData.objectRobberies : [];
    }

    function getSelectedPettyObjectEntry() {
        return getPettyObjectRobberies()[pettyCrimeUiState.selectedObjectIndex];
    }

    function normalizePettyCrimeData(data) {
        const defaults = getPettyCrimeDefaults();
        const input = parsePettyCrimeInput(data);
        const objectSource = Array.isArray(input.objectRobberies) ? input.objectRobberies : defaults.objectRobberies;
        const porchSource = (input.porchPirate && typeof input.porchPirate === 'object') ? input.porchPirate : defaults.porchPirate;
        const totalPorchLocations = Array.isArray(porchSource.locations) ? porchSource.locations.length : 0;
        let activeSpawnPercent = Number(porchSource.activeSpawnPercent);
        if (!Number.isFinite(activeSpawnPercent)) {
            const legacyMin = Number(porchSource.activeSpawnMin);
            const legacyMax = Number(porchSource.activeSpawnMax);
            if (totalPorchLocations > 0 && (Number.isFinite(legacyMin) || Number.isFinite(legacyMax))) {
                const safeMin = Number.isFinite(legacyMin) ? legacyMin : legacyMax;
                const safeMax = Number.isFinite(legacyMax) ? legacyMax : legacyMin;
                activeSpawnPercent = ((safeMin + safeMax) / 2 / totalPorchLocations) * 100;
            } else {
                activeSpawnPercent = defaults.porchPirate.activeSpawnPercent ?? 25;
            }
        }
        activeSpawnPercent = Math.max(0, Math.min(100, Math.round(activeSpawnPercent)));

        return {
            objectRobberies: objectSource
                .map((entry, index) => normalizePettyCrimeEntry(entry, defaults.objectRobberies[index] || {}))
                .filter((entry) => entry.models.length > 0 || String(entry.label || '').trim() !== ''),
            porchPirate: {
                ...normalizePettyCrimeEntry(porchSource, defaults.porchPirate),
                enabled: porchSource.enabled !== false,
                activeSpawnPercent,
                locations: (Array.isArray(porchSource.locations) ? porchSource.locations : [])
                    .map((location, index) => normalizePettyCrimeLocation(location, index))
                    .filter(Boolean),
                activeLocationIds: (Array.isArray(porchSource.activeLocationIds) ? porchSource.activeLocationIds : [])
                    .map((id) => String(id || '').trim())
                    .filter(Boolean),
            },
        };
    }

    function populatePettyPresetDropdown(selectId, configKey) {
        const select = document.getElementById(selectId);
        if (!select) return;

        const options = Array.isArray(Config?.[configKey]) ? Config[configKey] : [];
        select.innerHTML = '';
        options.forEach((entry) => {
            const option = document.createElement('option');
            option.value = entry.model;
            option.textContent = entry.label || entry.model;
            select.appendChild(option);
        });
    }

    function copySelectOptions(sourceId, targetId) {
        const source = document.getElementById(sourceId);
        const target = document.getElementById(targetId);
        if (!source || !target) return;
        target.innerHTML = source.innerHTML;
    }

    function populatePettyAlertSelects() {
        copySelectOptions('alertIcon', 'pettyObjectAlertIcon');
        copySelectOptions('alertPriority', 'pettyObjectAlertPriority');
        copySelectOptions('blipColor', 'pettyObjectBlipColor');
        copySelectOptions('alertSound1', 'pettyObjectAlertSound1');
        copySelectOptions('blipFlash', 'pettyObjectBlipFlash');
    }

    function renderPettyObjectModelList(entry) {
        const modelList = document.getElementById('pettyObjectModelList');
        const display = document.getElementById('pettyObjectModelDisplay');
        const meta = document.getElementById('pettyObjectModelMeta');
        if (!modelList) return;

        const models = normalizePettyCrimeModels(entry?.models, entry?.model);
        if (display) display.value = models.length ? models.join('\n') : '';
        if (meta) {
            meta.textContent = models.length === 0
                ? 'No object models linked yet'
                : (models.length === 1 ? '1 model linked to this setup' : `${models.length} models linked to this setup`);
        }
        modelList.innerHTML = '';

        models.forEach((model) => {
            const chip = document.createElement('div');
            chip.className = 'petty-object-model-chip';
            chip.dataset.model = model;
            chip.innerHTML = `
                <div class="petty-object-model-name">${escapePettyHtml(model)}</div>
                <button type="button" class="remove-target-button petty-object-model-remove">REMOVE</button>
            `;

            chip.querySelector('.petty-object-model-remove')?.addEventListener('click', () => {
                const currentEntry = getSelectedPettyObjectEntry();
                if (!currentEntry) return;
                currentEntry.models = (currentEntry.models || []).filter((item) => item !== model);
                currentEntry.model = currentEntry.models[0] || '';

                renderPettyObjectModelList(currentEntry);
                renderPettyCrimeObjectList();
            });

            modelList.appendChild(chip);
        });
    }

    function getPettyObjectEditorModels() {
        return Array.from(document.querySelectorAll('#pettyObjectModelList .petty-object-model-chip'))
            .map((chip) => String(chip.dataset.model || '').trim())
            .filter(Boolean);
    }

    function addModelToCurrentPettyObjectEntry(model) {
        const currentEntry = getSelectedPettyObjectEntry();
        const value = String(model || '').trim();
        if (!currentEntry || !value) return false;

        currentEntry.models = normalizePettyCrimeModels([...(currentEntry.models || []), value], currentEntry.model);
        currentEntry.model = currentEntry.models[0] || '';
        renderPettyObjectModelList(currentEntry);
        renderPettyCrimeObjectList();
        return true;
    }

    function addPettyPoliceJobRow(containerId, job = '') {
        const container = document.getElementById(containerId);
        if (!container) return;

        const row = document.createElement('div');
        row.className = 'petty-police-job';
        row.innerHTML = `
            <input type="text" class="petty-police-job-input" value="${escapePettyHtml(job)}" placeholder="Enter police job name">
            <button type="button" class="remove-target-button petty-police-job-remove">Remove</button>
        `;
        row.querySelector('.petty-police-job-remove')?.addEventListener('click', () => row.remove());
        container.appendChild(row);
    }

    function getPettyPoliceJobs(containerId) {
        const container = document.getElementById(containerId);
        if (!container) return [];
        return Array.from(container.querySelectorAll('.petty-police-job-input'))
            .map((input) => String(input.value || '').trim())
            .filter(Boolean);
    }

    function renderPettyObjectAlertSettings(entry) {
        document.getElementById('pettyObjectPoliceAlertHeader').value = entry.policeAlertHeader || '';
        document.getElementById('pettyObjectPoliceAlert').value = entry.policeAlert || '';
        document.getElementById('pettyObjectAlertCode').value = entry.alertCode || '10-90';
        document.getElementById('pettyObjectAlertCamId').value = entry.alertCamId || '';
        document.getElementById('pettyObjectAlertIcon').value = entry.alertIcon || 'fas fa-bell';
        document.getElementById('pettyObjectAlertPriority').value = entry.alertPriority || '2';
        document.getElementById('pettyObjectBlipSprite').value = entry.blipSprite ?? '59';
        document.getElementById('pettyObjectBlipColor').value = entry.blipColor ?? '0';
        document.getElementById('pettyObjectBlipScale').value = entry.blipScale ?? '1.0';
        document.getElementById('pettyObjectAlertSound1').value = entry.alertSound1 || 'robberysound';
        document.getElementById('pettyObjectBlipFlash').value = String(entry.blipFlash ?? false);

        const jobsContainer = document.getElementById('pettyObjectPoliceJobsContainer');
        if (jobsContainer) jobsContainer.innerHTML = '';
        (entry.policeJobs || []).forEach((job) => addPettyPoliceJobRow('pettyObjectPoliceJobsContainer', job));
        if (jobsContainer && jobsContainer.children.length === 0) {
            addPettyPoliceJobRow('pettyObjectPoliceJobsContainer', '');
        }
    }

    function openPettyObjectModelModal() {
        const page = getPettyCrimePageRoot();
        const panel = document.getElementById('pettyObjectModelOptions');
        const entry = getSelectedPettyObjectEntry();
        if (!page || !panel || !entry) return;

        renderPettyObjectModelList(entry);
        OpenFeatureModal(page, 'Object Robbery Models', panel);
        refreshPettyCrimeSelects(document.getElementById('rcFeatureModalBody') || panel);
    }

    function populatePettyMinigameDropdown(selectId, currentValue = 'none') {
        const select = document.getElementById(selectId);
        if (!select) return;

        const values = [{ value: 'none', label: 'None' }];
        Object.keys(Config?.MiniGames || {})
            .filter((key) => key !== 'numberpad' && key !== 'none')
            .sort((a, b) => (Config.MiniGames[a]?.label || a).localeCompare(Config.MiniGames[b]?.label || b))
            .forEach((key) => values.push({ value: key, label: Config.MiniGames[key]?.label || key }));

        select.innerHTML = '';
        values.forEach((entry) => {
            const option = document.createElement('option');
            option.value = entry.value;
            option.textContent = entry.label;
            select.appendChild(option);
        });
        select.value = currentValue || 'none';
    }

    const pettyFeatureDefs = [
        { key: 'objectAlert', title: 'Object Robbery Alert Settings', panelId: 'pettyObjectAlertOptions', alwaysVisible: true },
        { key: 'objectReqItems', title: 'Object Robbery Required Items', checkboxId: 'pettyObjectRequiredItemCheckbox', panelId: 'pettyObjectRequiredItemOptions', showButtonWhenHasData: false },
        { key: 'objectRewardItems', title: 'Object Robbery Reward Items', checkboxId: 'pettyObjectRewardItemCheckbox', panelId: 'pettyObjectRewardItemOptions', showButtonWhenHasData: false },
        { key: 'objectMoneyReward', title: 'Object Robbery Money Reward', checkboxId: 'pettyObjectMoneyRewardCheckbox', panelId: 'pettyObjectMoneyRewardOptions', showButtonWhenHasData: false },
        { key: 'porchReqItems', title: 'Porch Pirate Required Items', checkboxId: 'pettyPorchRequiredItemCheckbox', panelId: 'pettyPorchRequiredItemOptions', showButtonWhenHasData: false },
        { key: 'porchRewardItems', title: 'Porch Pirate Reward Items', checkboxId: 'pettyPorchRewardItemCheckbox', panelId: 'pettyPorchRewardItemOptions', showButtonWhenHasData: false },
        { key: 'porchMoneyReward', title: 'Porch Pirate Money Reward', checkboxId: 'pettyPorchMoneyRewardCheckbox', panelId: 'pettyPorchMoneyRewardOptions', showButtonWhenHasData: false },
    ];

    function getPettyCrimePageRoot() {
        return document.getElementById('pettyCrimesMainPage') || document.getElementById('pettyCrimesMainPageContainer') || document;
    }

    function refreshPettyCrimeSelects(root = null) {
        const scope = root || getPettyCrimePageRoot();
        try { rcEnhancePlainSelects(scope); } catch (e) {}
        try { rcEnhanceMiniGameSelects(scope); } catch (e) {}
        try { rcEnhanceRewardTypeSelects(scope); } catch (e) {}
    }

    function hidePettyCrimePanel(panel) {
        if (!panel) return;
        panel.classList.add('hidden');
        panel.style.display = 'none';
    }

    function hideAllPettyFeaturePanels() {
        pettyFeatureDefs.forEach(({ panelId }) => hidePettyCrimePanel(document.getElementById(panelId)));
    }

    function setPettyPanelVisibility(checkboxId, panelId) {
        const panel = document.getElementById(panelId);
        hidePettyCrimePanel(panel);
    }

    function addPettyRequiredItemRow(panelId, name = '', qty = 1, lose = 100) {
        const panel = document.getElementById(panelId);
        if (!panel) return;

        const list = panel.querySelector('.item-list') || panel;
        const row = document.createElement('div');
        row.className = 'section';
        row.innerHTML = `
            <div class="rcCombo" data-combo="item">
                <div class="rcComboSearch">
                    <i class="fas fa-magnifying-glass"></i>
                    <input type="text" class="item-name" placeholder="Search item" autocomplete="off" value="${String(name || '').replace(/"/g, '&quot;')}">
                    <i class="fas fa-chevron-down rcComboCaret"></i>
                </div>
                <div class="rcComboList hidden"></div>
            </div>
            <label class="quantity-label">Item Quantity</label>
            <input type="number" class="item-quantity" min="1" value="${parseInt(qty, 10) || 1}">
            <label class="lose-chance-label">Lose Chance (%)</label>
            <input type="number" class="lose-chance" min="0" max="100" value="${Number.isFinite(+lose) ? +lose : 100}">
            <button type="button" class="remove-item-button">Remove</button>
        `;
        row.querySelector('.remove-item-button')?.addEventListener('click', () => row.remove());
        list.appendChild(row);
    }

    function addPettyRewardItemRow(panelId, name = '', minAmount = 1, maxAmount = 1, chance = 100) {
        const panel = document.getElementById(panelId);
        if (!panel) return;

        const list = panel.querySelector('.reward-item-list') || panel;
        const wrap = document.createElement('div');
        wrap.className = 'reward-item';
        wrap.innerHTML = `
            <div class="section">
                <div class="rcCombo" data-combo="item">
                    <div class="rcComboSearch">
                        <i class="fas fa-magnifying-glass"></i>
                        <input type="text" class="reward-item-name" placeholder="Search item" autocomplete="off" value="${String(name || '').replace(/"/g, '&quot;')}">
                        <i class="fas fa-chevron-down rcComboCaret"></i>
                    </div>
                    <div class="rcComboList hidden"></div>
                </div>
                <div>
                    <label>Min Amount</label>
                    <input type="number" class="reward-item-min" min="1" value="${parseInt(minAmount, 10) || 1}">
                </div>
                <div>
                    <label>Max Amount</label>
                    <input type="number" class="reward-item-max" min="1" value="${parseInt(maxAmount, 10) || 1}">
                </div>
                <div>
                    <label>Reward Chance (%)</label>
                    <input type="number" class="reward-item-chance" min="0" max="100" value="${Number.isFinite(+chance) ? +chance : 100}">
                </div>
                <button type="button" class="remove-reward-item-button">Remove</button>
            </div>
        `;
        wrap.querySelector('.remove-reward-item-button')?.addEventListener('click', () => wrap.remove());
        list.appendChild(wrap);
    }

    function getPettyRequiredItems(panelId) {
        const panel = document.getElementById(panelId);
        if (!panel) return [];

        const rows = [];
        panel.querySelectorAll('.section').forEach((row) => {
            const name = row.querySelector('.item-name')?.value?.trim();
            if (!name) return;
            rows.push({
                itemName: name,
                amount: row.querySelector('.item-quantity')?.value ?? 1,
                chance: row.querySelector('.lose-chance')?.value ?? 100,
            });
        });
        return rows;
    }

    function getPettyRewardItems(panelId) {
        const panel = document.getElementById(panelId);
        if (!panel) return [];

        const rows = [];
        panel.querySelectorAll('.reward-item').forEach((row) => {
            const name = row.querySelector('.reward-item-name')?.value?.trim();
            if (!name) return;
            rows.push({
                itemName: name,
                minAmount: row.querySelector('.reward-item-min')?.value ?? 1,
                maxAmount: row.querySelector('.reward-item-max')?.value ?? 1,
                chance: row.querySelector('.reward-item-chance')?.value ?? 100,
            });
        });
        return rows;
    }

    function pettyPanelHasData(panelId) {
        const panel = document.getElementById(panelId);
        if (!panel) return false;
        return (typeof rcHasMeaningfulData === 'function') ? rcHasMeaningfulData(panel) : false;
    }

    function syncPettyFeatureToggleState(featureKey, checked) {
        const isChecked = !!checked;
        const objectEntry = getSelectedPettyObjectEntry();
        const porch = pettyCrimeData.porchPirate || {};

        switch (featureKey) {
        case 'objectReqItems':
            if (objectEntry) objectEntry.requiredItemsEnabled = isChecked;
            break;
        case 'objectRewardItems':
            if (objectEntry) objectEntry.rewardItemsEnabled = isChecked;
            break;
        case 'objectMoneyReward':
            if (objectEntry) {
                objectEntry.moneyRewardEnabled = isChecked;
                objectEntry.moneyReward = isChecked;
            }
            break;
        case 'porchReqItems':
            porch.requiredItemsEnabled = isChecked;
            break;
        case 'porchRewardItems':
            porch.rewardItemsEnabled = isChecked;
            break;
        case 'porchMoneyReward':
            porch.moneyRewardEnabled = isChecked;
            porch.moneyReward = isChecked;
            break;
        default:
            break;
        }
    }

    function ensurePettyFeatureEnabledByPanel(panelOrId) {
        const panelId = typeof panelOrId === 'string'
            ? panelOrId
            : (panelOrId && panelOrId.id ? panelOrId.id : '');

        const panelMap = {
            pettyObjectRequiredItemOptions: { key: 'objectReqItems', checkboxId: 'pettyObjectRequiredItemCheckbox' },
            pettyObjectRewardItemOptions: { key: 'objectRewardItems', checkboxId: 'pettyObjectRewardItemCheckbox' },
            pettyObjectMoneyRewardOptions: { key: 'objectMoneyReward', checkboxId: 'pettyObjectMoneyRewardCheckbox' },
            pettyPorchRequiredItemOptions: { key: 'porchReqItems', checkboxId: 'pettyPorchRequiredItemCheckbox' },
            pettyPorchRewardItemOptions: { key: 'porchRewardItems', checkboxId: 'pettyPorchRewardItemCheckbox' },
            pettyPorchMoneyRewardOptions: { key: 'porchMoneyReward', checkboxId: 'pettyPorchMoneyRewardCheckbox' },
        };

        const mapped = panelMap[panelId];
        if (!mapped) return false;

        const checkbox = document.getElementById(mapped.checkboxId);
        if (checkbox) checkbox.checked = true;

        syncPettyFeatureToggleState(mapped.key, true);
        if (mapped.key.startsWith('object')) {
            savePettyObjectEditorToState();
        } else if (mapped.key.startsWith('porch')) {
            capturePettyPorchState();
        }
        rcUpdatePettyCrimeFeatureButtons();
        return true;
    }

    window.rcEnsurePettyFeatureEnabledByPanel = ensurePettyFeatureEnabledByPanel;

    function rcUpdatePettyCrimeFeatureButtons() {
        pettyFeatureDefs.forEach((def) => {
            const checkbox = document.getElementById(def.checkboxId);
            const panel = document.getElementById(def.panelId);
            if (!panel) return;

            const tile = (checkbox?.closest('.section') || checkbox?.closest('.section2') || panel.closest('.section') || panel.closest('.section2') || null);
            if (!tile) return;

            const button = tile.querySelector(`.rc-feature-open[data-petty-key="${def.key}"]`);
            if (!button) return;

            const hasData = (typeof rcHasMeaningfulData === 'function') ? rcHasMeaningfulData(panel) : false;
            const shouldShowButton = !!(
                def.alwaysVisible
                || checkbox?.checked
                || (def.showButtonWhenHasData !== false && hasData)
            );
            button.classList.toggle('hidden', !shouldShowButton);

            if (!rcFeatureModalIsOpen() || typeof _rcFeature === 'undefined' || !_rcFeature || _rcFeature.panel !== panel) {
                hidePettyCrimePanel(panel);
            }
        });
    }

    function bindPettyCrimeFeatureToggles() {
        const page = getPettyCrimePageRoot();

        pettyFeatureDefs.forEach((def) => {
            const checkbox = document.getElementById(def.checkboxId);
            const panel = document.getElementById(def.panelId);
            if (!panel) return;

            hidePettyCrimePanel(panel);

            const tile = (checkbox?.closest('.section') || checkbox?.closest('.section2') || panel.closest('.section') || panel.closest('.section2') || null);
            if (!tile) return;

            const label = checkbox?.closest('.rc-inline-check') || tile.querySelector('.rc-inline-check');
            if (!label) return;

            let controls = label.querySelector('.rc-inline-check__controls');
            if (!controls) {
                controls = document.createElement('span');
                controls.className = 'rc-inline-check__controls';
                label.appendChild(controls);
            }

            if (checkbox && checkbox.parentElement !== controls) {
                controls.appendChild(checkbox);
            }

            let button = controls.querySelector(`.rc-feature-open[data-petty-key="${def.key}"]`) || tile.querySelector(`.rc-feature-open[data-petty-key="${def.key}"]`);
            if (!button) {
                button = document.createElement('button');
                button.type = 'button';
                button.className = 'rc-feature-open hidden';
                button.dataset.pettyKey = def.key;
                button.innerHTML = '<i class="fas fa-sliders-h"></i>';
                button.title = def.title;
                button.addEventListener('click', (event) => {
                    event.preventDefault();
                    event.stopPropagation();
                    OpenFeatureModal(page, def.title, panel);
                });
            }

            if (button.parentElement !== controls) {
                if (checkbox) {
                    controls.insertBefore(button, checkbox);
                } else {
                    controls.appendChild(button);
                }
            }

            if (!checkbox) {
                return;
            }

            if (checkbox.dataset.rcPettyFeatureBound !== '1') {
                checkbox.dataset.rcPettyFeatureBound = '1';
                checkbox.addEventListener('change', (event) => {
                    const silent = !!(event && (event.rcSilent || event.silent));
                    const isChecked = !!checkbox.checked;
                    hidePettyCrimePanel(panel);
                    syncPettyFeatureToggleState(def.key, isChecked);

                    const persistToggleState = () => {
                        syncPettyFeatureToggleState(def.key, checkbox.checked);
                        if (def.key.startsWith('object')) {
                            savePettyObjectEditorToState();
                        } else if (def.key.startsWith('porch')) {
                            capturePettyPorchState();
                        }
                        rcUpdatePettyCrimeFeatureButtons();
                    };

                    if (!isChecked) {
                        persistToggleState();
                        try {
                            if (rcFeatureModalIsOpen() && typeof _rcFeature !== 'undefined' && _rcFeature && _rcFeature.panel === panel) {
                                CloseFeatureModal();
                            }
                        } catch (e) {}
                        return;
                    }

                    if (silent) {
                        persistToggleState();
                        return;
                    }

                    requestAnimationFrame(() => {
                        checkbox.checked = true;
                        persistToggleState();
                        OpenFeatureModal(page, def.title, panel);
                    });
                });
            }
        });

        rcUpdatePettyCrimeFeatureButtons();
    }

    function renderPettyCrimeObjectList() {
        const list = document.getElementById('pettyObjectRobberyList');
        if (!list) return;
        const objectRobberies = getPettyObjectRobberies();

        list.innerHTML = '';
        objectRobberies.forEach((entry, index) => {
            const button = document.createElement('button');
            button.type = 'button';
            button.className = `petty-crime-list-item ${index === pettyCrimeUiState.selectedObjectIndex ? 'active' : ''}`;
            button.innerHTML = `
                <span>
                    <strong>${escapePettyHtml(entry.label || entry.model || 'Object Robbery')}</strong>
                </span>
                <span class="petty-crime-status ${entry.enabled ? 'is-enabled' : 'is-disabled'}">${entry.enabled ? 'Live' : 'Off'}</span>
            `;
            button.addEventListener('click', () => {
                savePettyObjectEditorToState();
                pettyCrimeUiState.selectedObjectIndex = index;
                renderPettyCrimeObjectList();
                renderPettyCrimeObjectEditor();
            });
            list.appendChild(button);
        });
    }

    function renderPettyCrimeObjectEditor() {
        const emptyState = document.getElementById('pettyObjectEmptyState');
        const editor = document.getElementById('pettyObjectEditor');
        const entry = getSelectedPettyObjectEntry();

        if (!entry) {
            if (emptyState) emptyState.style.display = 'flex';
            if (editor) editor.style.display = 'none';
            return;
        }

        if (emptyState) emptyState.style.display = 'none';
        if (editor) editor.style.display = 'block';
        hideAllPettyFeaturePanels();

        entry.models = normalizePettyCrimeModels(entry.models, entry.model);
        entry.model = entry.models[0] || '';
        document.getElementById('pettyObjectEnabled').checked = !!entry.enabled;
        document.getElementById('pettyObjectLabel').value = entry.label || '';
        document.getElementById('pettyObjectInteractionLabel').value = entry.interactionLabel || '';
        document.getElementById('pettyObjectProgressLabel').value = entry.progressLabel || '';
        document.getElementById('pettyObjectProgressDuration').value = entry.progressDuration ?? 7000;
        document.getElementById('pettyObjectPoliceRequired').value = entry.policeRequired ?? 0;
        document.getElementById('pettyObjectAlertChance').value = entry.alertChance ?? 100;
        document.getElementById('pettyObjectCooldown').value = entry.cooldown ?? 15;
        populatePettyMinigameDropdown('pettyObjectMinigameOption', entry.minigameOption || 'none');
        const modelPreset = document.getElementById('pettyObjectEditorModelPreset');
        if (modelPreset) modelPreset.value = entry.models[0] || modelPreset.options?.[0]?.value || '';
        const customModelInput = document.getElementById('pettyObjectEditorCustomModel');
        if (customModelInput) customModelInput.value = '';
        renderPettyObjectModelList(entry);
        hidePettyCrimePanel(document.getElementById('pettyObjectModelOptions'));

        const reqCheckbox = document.getElementById('pettyObjectRequiredItemCheckbox');
        const rewardCheckbox = document.getElementById('pettyObjectRewardItemCheckbox');
        const moneyCheckbox = document.getElementById('pettyObjectMoneyRewardCheckbox');
        renderPettyObjectAlertSettings(entry);
        const hasRequiredItems = Array.isArray(entry.requiredItems) && entry.requiredItems.length > 0;
        const hasRewardItems = Array.isArray(entry.rewardItems) && entry.rewardItems.length > 0;
        entry.requiredItemsEnabled = !!entry.requiredItemsEnabled || hasRequiredItems;
        entry.rewardItemsEnabled = !!entry.rewardItemsEnabled || hasRewardItems;
        entry.moneyRewardEnabled = !!entry.moneyRewardEnabled || !!entry.moneyReward;
        entry.moneyReward = !!entry.moneyRewardEnabled;

        reqCheckbox.checked = !!entry.requiredItemsEnabled;
        rewardCheckbox.checked = !!entry.rewardItemsEnabled;
        moneyCheckbox.checked = !!entry.moneyRewardEnabled;

        document.getElementById('pettyObjectRewardTypeDropdown').value = entry.rewardType || 'cash';
        document.getElementById('pettyObjectRewardMinMoney').value = entry.minMoney ?? 25;
        document.getElementById('pettyObjectRewardMaxMoney').value = entry.maxMoney ?? 75;
        document.getElementById('pettyObjectRewardMoneyChance').value = entry.moneyChance ?? 100;

        const reqList = document.querySelector('#pettyObjectRequiredItemOptions .item-list');
        const rewardList = document.querySelector('#pettyObjectRewardItemOptions .reward-item-list');
        if (reqList) reqList.innerHTML = '';
        if (rewardList) rewardList.innerHTML = '';

        (entry.requiredItems || []).forEach((item) => addPettyRequiredItemRow('pettyObjectRequiredItemOptions', item.itemName, item.amount, item.chance));
        (entry.rewardItems || []).forEach((item) => addPettyRewardItemRow('pettyObjectRewardItemOptions', item.itemName, item.minAmount, item.maxAmount, item.chance));

        hidePettyCrimePanel(document.getElementById('pettyObjectAlertOptions'));
        hidePettyCrimePanel(document.getElementById('pettyObjectRequiredItemOptions'));
        hidePettyCrimePanel(document.getElementById('pettyObjectRewardItemOptions'));
        hidePettyCrimePanel(document.getElementById('pettyObjectMoneyRewardOptions'));
        rcUpdatePettyCrimeFeatureButtons();
        refreshPettyCrimeSelects(editor);
    }

    function savePettyObjectEditorToState() {
        pettyCrimeData = normalizePettyCrimeData(pettyCrimeData);
        const objectRobberies = getPettyObjectRobberies();
        if (pettyCrimeUiState.selectedObjectIndex < 0 || pettyCrimeUiState.selectedObjectIndex >= objectRobberies.length) {
            pettyCrimeUiState.selectedObjectIndex = Math.max(0, objectRobberies.length - 1);
        }
        const entry = getSelectedPettyObjectEntry();
        const editor = document.getElementById('pettyObjectEditor');
        if (!entry || !editor || editor.style.display === 'none') return;

        entry.models = normalizePettyCrimeModels(getPettyObjectEditorModels(), entry.model);
        entry.model = entry.models[0] || '';
        entry.enabled = document.getElementById('pettyObjectEnabled').checked;
        entry.label = document.getElementById('pettyObjectLabel').value.trim() || entry.label || entry.model || 'Object Robbery';
        entry.interactionLabel = document.getElementById('pettyObjectInteractionLabel').value.trim() || `Rob ${entry.label}`;
        entry.progressLabel = document.getElementById('pettyObjectProgressLabel').value.trim() || `Searching ${entry.label.toLowerCase()}`;
        entry.progressDuration = document.getElementById('pettyObjectProgressDuration').value || 7000;
        entry.policeRequired = document.getElementById('pettyObjectPoliceRequired').value || 0;
        entry.alertChance = document.getElementById('pettyObjectAlertChance').value || 100;
        entry.cooldown = document.getElementById('pettyObjectCooldown').value || 0;
        entry.minigameOption = document.getElementById('pettyObjectMinigameOption').value || 'none';
        entry.policeAlertHeader = document.getElementById('pettyObjectPoliceAlertHeader').value.trim() || `${entry.label} Being Robbed`;
        entry.policeAlert = document.getElementById('pettyObjectPoliceAlert').value.trim() || `${entry.label} robbery in progress.`;
        entry.policeJobs = getPettyPoliceJobs('pettyObjectPoliceJobsContainer');
        entry.alertCode = document.getElementById('pettyObjectAlertCode').value.trim() || '10-90';
        entry.alertCamId = document.getElementById('pettyObjectAlertCamId').value.trim() || '';
        entry.alertIcon = document.getElementById('pettyObjectAlertIcon').value || 'fas fa-bell';
        entry.alertPriority = document.getElementById('pettyObjectAlertPriority').value || '2';
        entry.blipSprite = document.getElementById('pettyObjectBlipSprite').value || '59';
        entry.blipColor = document.getElementById('pettyObjectBlipColor').value || '0';
        entry.blipScale = document.getElementById('pettyObjectBlipScale').value || '1.0';
        entry.alertSound1 = document.getElementById('pettyObjectAlertSound1').value || 'robberysound';
        entry.blipFlash = document.getElementById('pettyObjectBlipFlash').value === 'true';
        entry.moneyRewardEnabled = !!document.getElementById('pettyObjectMoneyRewardCheckbox').checked;
        entry.moneyReward = entry.moneyRewardEnabled;
        entry.rewardType = document.getElementById('pettyObjectRewardTypeDropdown').value || 'cash';
        entry.minMoney = document.getElementById('pettyObjectRewardMinMoney').value || 25;
        entry.maxMoney = document.getElementById('pettyObjectRewardMaxMoney').value || 75;
        entry.moneyChance = document.getElementById('pettyObjectRewardMoneyChance').value || 100;
        entry.requiredItemsEnabled = !!document.getElementById('pettyObjectRequiredItemCheckbox').checked;
        entry.rewardItemsEnabled = !!document.getElementById('pettyObjectRewardItemCheckbox').checked;
        entry.requiredItems = (entry.requiredItemsEnabled || pettyPanelHasData('pettyObjectRequiredItemOptions'))
            ? getPettyRequiredItems('pettyObjectRequiredItemOptions')
            : [];
        entry.rewardItems = (entry.rewardItemsEnabled || pettyPanelHasData('pettyObjectRewardItemOptions'))
            ? getPettyRewardItems('pettyObjectRewardItemOptions')
            : [];
    }

    function capturePettyPorchState() {
        const porch = pettyCrimeData.porchPirate || {};
        let activeSpawnPercent = Number(document.getElementById('pettyPorchActiveSpawnPercent')?.value ?? 25);
        if (!Number.isFinite(activeSpawnPercent)) activeSpawnPercent = 25;
        activeSpawnPercent = Math.max(0, Math.min(100, Math.round(activeSpawnPercent)));

        porch.enabled = document.getElementById('pettyPorchEnabled')?.checked ?? true;
        porch.interactionLabel = document.getElementById('pettyPorchInteractionLabel')?.value?.trim() || 'Steal Package';
        porch.progressLabel = document.getElementById('pettyPorchProgressLabel')?.value?.trim() || 'Snatching package';
        porch.progressDuration = document.getElementById('pettyPorchProgressDuration')?.value || 5000;
        porch.policeRequired = document.getElementById('pettyPorchPoliceRequired')?.value || 0;
        porch.cooldown = document.getElementById('pettyPorchCooldown')?.value || 20;
        porch.activeSpawnPercent = activeSpawnPercent;
        porch.minigameOption = document.getElementById('pettyPorchMinigameOption')?.value || 'none';
        porch.moneyRewardEnabled = !!document.getElementById('pettyPorchMoneyRewardCheckbox')?.checked;
        porch.moneyReward = porch.moneyRewardEnabled;
        porch.rewardType = document.getElementById('pettyPorchRewardTypeDropdown')?.value || 'cash';
        porch.minMoney = document.getElementById('pettyPorchRewardMinMoney')?.value || 50;
        porch.maxMoney = document.getElementById('pettyPorchRewardMaxMoney')?.value || 150;
        porch.requiredItemsEnabled = !!document.getElementById('pettyPorchRequiredItemCheckbox')?.checked;
        porch.rewardItemsEnabled = !!document.getElementById('pettyPorchRewardItemCheckbox')?.checked;
        porch.requiredItems = (porch.requiredItemsEnabled || pettyPanelHasData('pettyPorchRequiredItemOptions'))
            ? getPettyRequiredItems('pettyPorchRequiredItemOptions')
            : [];
        porch.rewardItems = (porch.rewardItemsEnabled || pettyPanelHasData('pettyPorchRewardItemOptions'))
            ? getPettyRewardItems('pettyPorchRewardItemOptions')
            : [];

        const list = document.getElementById('pettyPorchLocationList');
        if (list) {
            const updatedLocations = [];
            list.querySelectorAll('.petty-crime-location-card').forEach((card) => {
                const index = Number(card.dataset.index);
                const current = porch.locations?.[index];
                if (!current) return;
                updatedLocations.push({
                    ...current,
                    label: card.querySelector('.petty-porch-location-label')?.value?.trim() || current.label,
                });
            });
            porch.locations = updatedLocations;
        }

        pettyCrimeData.porchPirate = porch;
        const percentInput = document.getElementById('pettyPorchActiveSpawnPercent');
        if (percentInput) percentInput.value = activeSpawnPercent;
    }

    function renderPettyPorchLocationList() {
        const list = document.getElementById('pettyPorchLocationList');
        if (!list) return;

        list.innerHTML = '';
        const locations = pettyCrimeData.porchPirate?.locations || [];
        if (locations.length === 0) {
            const empty = document.createElement('div');
            empty.className = 'petty-crime-location-empty';
            empty.textContent = 'No package locations placed yet.';
            list.appendChild(empty);
            return;
        }

        locations.forEach((location, index) => {
            const card = document.createElement('div');
            card.className = 'petty-crime-location-card';
            card.dataset.index = String(index);
            card.innerHTML = `
                <div class="petty-crime-location-top">
                    <input type="text" class="petty-porch-location-label" value="${String(location.label || '').replace(/"/g, '&quot;')}">
                    <button type="button" class="remove-target-button petty-porch-remove">Remove</button>
                </div>
                <div class="petty-crime-location-meta">${escapePettyHtml(location.model || 'Random porch box model from config')}</div>
                <div class="petty-crime-location-coords">${location.coords.x.toFixed(2)}, ${location.coords.y.toFixed(2)}, ${location.coords.z.toFixed(2)} | H ${Number(location.heading || 0).toFixed(2)}</div>
                <div class="petty-porch-location-actions">
                    <button type="button" class="save-banktruck-button petty-porch-replace">REPLACE</button>
                    <button type="button" class="remove-target-button petty-porch-teleport">TELEPORT</button>
                </div>
            `;

            card.querySelector('.petty-porch-remove')?.addEventListener('click', () => {
                capturePettyPorchState();
                pettyCrimeData.porchPirate.locations.splice(index, 1);
                renderPettyPorchLocationList();
            });

            card.querySelector('.petty-porch-replace')?.addEventListener('click', () => placePorchPirateLocation(index));
            card.querySelector('.petty-porch-teleport')?.addEventListener('click', () => teleportToPorchPirateLocation(location));
            list.appendChild(card);
        });
    }

    function teleportToPorchPirateLocation(location) {
        const coords = location?.coords || {};
        const x = Number(coords.x);
        const y = Number(coords.y);
        const z = Number(coords.z);
        if (!Number.isFinite(x) || !Number.isFinite(y) || !Number.isFinite(z)) {
            notifyPettyPreset('Place this package location first.', 'error');
            return;
        }

        $.post(`https://${GetParentResourceName()}/TeleportToPosition`, JSON.stringify({
            x,
            y,
            z,
            heading: Number(location.heading || 0),
        }));
    }

    function renderPettyPorchPanel() {
        const porch = pettyCrimeData.porchPirate || {};
        hideAllPettyFeaturePanels();
        document.getElementById('pettyPorchEnabled').checked = porch.enabled !== false;
        document.getElementById('pettyPorchInteractionLabel').value = porch.interactionLabel || 'Steal Package';
        document.getElementById('pettyPorchProgressLabel').value = porch.progressLabel || 'Snatching package';
        document.getElementById('pettyPorchProgressDuration').value = porch.progressDuration ?? 5000;
        document.getElementById('pettyPorchPoliceRequired').value = porch.policeRequired ?? 0;
        document.getElementById('pettyPorchCooldown').value = porch.cooldown ?? 20;
        document.getElementById('pettyPorchActiveSpawnPercent').value = porch.activeSpawnPercent ?? 25;
        populatePettyMinigameDropdown('pettyPorchMinigameOption', porch.minigameOption || 'none');

        const reqCheckbox = document.getElementById('pettyPorchRequiredItemCheckbox');
        const rewardCheckbox = document.getElementById('pettyPorchRewardItemCheckbox');
        const moneyCheckbox = document.getElementById('pettyPorchMoneyRewardCheckbox');
        const hasRequiredItems = Array.isArray(porch.requiredItems) && porch.requiredItems.length > 0;
        const hasRewardItems = Array.isArray(porch.rewardItems) && porch.rewardItems.length > 0;
        porch.requiredItemsEnabled = !!porch.requiredItemsEnabled || hasRequiredItems;
        porch.rewardItemsEnabled = !!porch.rewardItemsEnabled || hasRewardItems;
        porch.moneyRewardEnabled = !!porch.moneyRewardEnabled || !!porch.moneyReward;
        porch.moneyReward = !!porch.moneyRewardEnabled;

        reqCheckbox.checked = !!porch.requiredItemsEnabled;
        rewardCheckbox.checked = !!porch.rewardItemsEnabled;
        moneyCheckbox.checked = !!porch.moneyRewardEnabled;

        document.getElementById('pettyPorchRewardTypeDropdown').value = porch.rewardType || 'cash';
        document.getElementById('pettyPorchRewardMinMoney').value = porch.minMoney ?? 50;
        document.getElementById('pettyPorchRewardMaxMoney').value = porch.maxMoney ?? 150;

        const reqList = document.querySelector('#pettyPorchRequiredItemOptions .item-list');
        const rewardList = document.querySelector('#pettyPorchRewardItemOptions .reward-item-list');
        if (reqList) reqList.innerHTML = '';
        if (rewardList) rewardList.innerHTML = '';

        (porch.requiredItems || []).forEach((item) => addPettyRequiredItemRow('pettyPorchRequiredItemOptions', item.itemName, item.amount, item.chance));
        (porch.rewardItems || []).forEach((item) => addPettyRewardItemRow('pettyPorchRewardItemOptions', item.itemName, item.minAmount, item.maxAmount, item.chance));

        hidePettyCrimePanel(document.getElementById('pettyPorchRequiredItemOptions'));
        hidePettyCrimePanel(document.getElementById('pettyPorchRewardItemOptions'));
        hidePettyCrimePanel(document.getElementById('pettyPorchMoneyRewardOptions'));
        hidePettyCrimePanel(document.getElementById('pettyPorchLocationOptions'));
        renderPettyPorchLocationList();
        rcUpdatePettyCrimeFeatureButtons();
        refreshPettyCrimeSelects(document.getElementById('pettyPorchPiratePanel'));
    }

    function switchPettyCrimePanel(panelKey) {
        savePettyObjectEditorToState();
        capturePettyPorchState();
        try {
            if (rcFeatureModalIsOpen()) CloseFeatureModal({ restorePrevious: false, forceAll: true });
        } catch (e) {}
        pettyCrimeUiState.activePanel = panelKey;

        document.getElementById('pettyCrimeObjectTab')?.classList.toggle('active', panelKey === 'objects');
        document.getElementById('pettyCrimePorchTab')?.classList.toggle('active', panelKey === 'porch');
        const objectPanel = document.getElementById('pettyObjectRobberiesPanel');
        const porchPanel = document.getElementById('pettyPorchPiratePanel');
        if (objectPanel) objectPanel.style.display = panelKey === 'objects' ? 'block' : 'none';
        if (porchPanel) porchPanel.style.display = panelKey === 'porch' ? 'block' : 'none';
        hideAllPettyFeaturePanels();
        rcUpdatePettyCrimeFeatureButtons();
        refreshPettyCrimeSelects(getPettyCrimePageRoot());
    }

    async function placePorchPirateLocation(existingIndex = null) {
        capturePettyPorchState();
        try {
            if (typeof CloseFeatureModal === 'function' && rcFeatureModalIsOpen()) {
                CloseFeatureModal({ restorePrevious: false, forceAll: true });
            }
        } catch (error) {}

        const overlay = document.getElementById('overlay');
        const previousOverlayDisplay = overlay ? overlay.style.display : '';
        if (overlay) overlay.style.display = 'none';

        try {
            const response = await fetch(`https://${GetParentResourceName()}/PlacePorchPirateLocation`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({}),
            });
            const result = await response.json();
            if (!result?.success || !result.location) return;

            const location = normalizePettyCrimeLocation({
                id: existingIndex === null
                    ? `porch_${Date.now()}_${Math.floor(Math.random() * 1000)}`
                    : pettyCrimeData.porchPirate.locations[existingIndex]?.id,
                label: existingIndex === null
                    ? `Package Spot ${(pettyCrimeData.porchPirate.locations?.length || 0) + 1}`
                    : pettyCrimeData.porchPirate.locations[existingIndex]?.label,
                heading: result.location.heading,
                model: result.location.model,
                coords: result.location.coords,
            }, existingIndex ?? pettyCrimeData.porchPirate.locations.length);

            if (!location) return;
            if (existingIndex === null) pettyCrimeData.porchPirate.locations.push(location);
            else pettyCrimeData.porchPirate.locations[existingIndex] = location;
            renderPettyPorchLocationList();
        } catch (error) {
            console.error('Failed to place porch pirate location:', error);
        } finally {
            if (overlay) overlay.style.display = previousOverlayDisplay;
        }
    }

    function openPettyPorchLocationModal() {
        const page = getPettyCrimePageRoot();
        const panel = document.getElementById('pettyPorchLocationOptions');
        if (!page || !panel) return;

        capturePettyPorchState();
        renderPettyPorchLocationList();
        OpenFeatureModal(page, 'Porch Pirate Locations', panel);
    }

    function bindPettyCrimeButtons() {
        const bind = (id, handler) => {
            const element = document.getElementById(id);
            if (!element || element.dataset.rcBound === '1') return;
            element.dataset.rcBound = '1';
            element.addEventListener('click', handler);
        };

        bind('pettyCrimeObjectTab', () => switchPettyCrimePanel('objects'));
        bind('pettyCrimePorchTab', () => switchPettyCrimePanel('porch'));
        bind('addPorchPirateLocationButton', () => placePorchPirateLocation());
        bind('openPettyPorchLocationsModalButton', (event) => {
            event.preventDefault();
            event.stopPropagation();
            openPettyPorchLocationModal();
        });
        bind('savePettyCrimeDataButton', SavePettyCrimeData);
        bind('loadPettyCrimePresetButton', () => openPettyPresetModal('load'));
        bind('savePettyCrimePresetButton', () => openPettyPresetModal('save'));
        bind('addPettyObjectPoliceJobButton', () => addPettyPoliceJobRow('pettyObjectPoliceJobsContainer', ''));
        bind('openPettyObjectModelModalButton', (event) => {
            event.preventDefault();
            event.stopPropagation();
            openPettyObjectModelModal();
        });
        bind('addPettyObjectEditorModelButton', () => {
            const model = document.getElementById('pettyObjectEditorCustomModel')?.value?.trim()
                || document.getElementById('pettyObjectEditorModelPreset')?.value
                || '';
            if (!addModelToCurrentPettyObjectEntry(model)) return;

            const customInput = document.getElementById('pettyObjectEditorCustomModel');
            if (customInput) customInput.value = '';
        });

        const addObjectButton = document.getElementById('addPettyObjectRobberyButton');
        if (addObjectButton && addObjectButton.dataset.rcBound !== '1') {
            addObjectButton.dataset.rcBound = '1';
            addObjectButton.addEventListener('click', () => {
                savePettyObjectEditorToState();
                const objectRobberies = getPettyObjectRobberies();

                const robberyName = document.getElementById('pettyObjectRobberyName')?.value?.trim();
                if (!robberyName) return;

                objectRobberies.push(normalizePettyCrimeEntry({
                    label: robberyName,
                    model: '',
                    models: [],
                    interactionLabel: `Rob ${robberyName}`,
                    progressLabel: `Searching ${robberyName.toLowerCase()}`,
                    sendAlert: false,
                    enabled: true,
                }));

                pettyCrimeUiState.selectedObjectIndex = objectRobberies.length - 1;
                const nameInput = document.getElementById('pettyObjectRobberyName');
                if (nameInput) nameInput.value = '';
                renderPettyCrimeObjectList();
                renderPettyCrimeObjectEditor();
            });
        }

        const removeButton = document.getElementById('removePettyObjectRobberyButton');
        if (removeButton && removeButton.dataset.rcBound !== '1') {
            removeButton.dataset.rcBound = '1';
            removeButton.addEventListener('click', () => {
                const objectRobberies = getPettyObjectRobberies();
                if (!objectRobberies.length) return;
                objectRobberies.splice(pettyCrimeUiState.selectedObjectIndex, 1);
                pettyCrimeUiState.selectedObjectIndex = Math.max(0, pettyCrimeUiState.selectedObjectIndex - 1);
                renderPettyCrimeObjectList();
                renderPettyCrimeObjectEditor();
            });
        }
    }

    window.LoadPettyCrimeData = function LoadPettyCrimeData(data) {
        pettyCrimeData = normalizePettyCrimeData(data);
        if (pettyCrimeUiState.selectedObjectIndex < 0 || pettyCrimeUiState.selectedObjectIndex >= pettyCrimeData.objectRobberies.length) {
            pettyCrimeUiState.selectedObjectIndex = Math.max(0, pettyCrimeData.objectRobberies.length - 1);
        }

        populatePettyPresetDropdown('pettyObjectEditorModelPreset', 'PettyCrimeObjectModels');
        populatePettyAlertSelects();
        try { bindItemHandlers(); } catch (e) {}
        bindPettyCrimeFeatureToggles();
        bindPettyCrimeButtons();
        renderPettyCrimeObjectList();
        renderPettyCrimeObjectEditor();
        renderPettyPorchPanel();
        switchPettyCrimePanel(pettyCrimeUiState.activePanel || 'objects');
        refreshPettyCrimeSelects(document.getElementById('pettyCrimesMainPageContainer') || document);
        rcUpdatePettyCrimeFeatureButtons();
    };

    window.showPettyCrimeMenu = function showPettyCrimeMenu() {
        savePettyObjectEditorToState();
        capturePettyPorchState();
        if (typeof rcCloseAllHomeSubPages === 'function') rcCloseAllHomeSubPages('petty');

        if (primaryContainer) primaryContainer.style.display = 'block';
        if (pettyCrimesMainPageContainer) pettyCrimesMainPageContainer.style.display = 'block';
        const pettyPage = document.getElementById('pettyCrimesMainPage');
        if (pettyPage) pettyPage.style.display = 'block';

        const bankWrap = document.getElementById('BankTruckMainPage');
        const atmWrap = document.getElementById('atmRobberyMainPageContainer');
        const sellWrap = document.getElementById('sellLocationMainPageContainer');
        const miniWrap = document.getElementById('miniGameSettingsMainPageContainer');
        const home = document.getElementById('mainRobberySettingsPage');

        if (bankWrap) bankWrap.style.display = 'none';
        if (atmWrap) atmWrap.style.display = 'none';
        if (sellWrap) sellWrap.style.display = 'none';
        if (miniWrap) miniWrap.style.display = 'none';
        if (home) home.style.display = 'none';

        window.LoadPettyCrimeData(pettyCrimeData);
        refreshPettyCrimeSelects(getPettyCrimePageRoot());
        rcUpdatePettyCrimeFeatureButtons();
        if (typeof rcSetView === 'function') rcSetView('petty');
    };

    window.SavePettyCrimeData = function SavePettyCrimeData() {
        try { if (rcFeatureModalIsOpen()) CloseFeatureModal({ restorePrevious: false, forceAll: true }); } catch (e) {}
        savePettyObjectEditorToState();
        capturePettyPorchState();

        fetch(`https://${GetParentResourceName()}/SavePettyCrimeData`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(pettyCrimeData),
        })
            .then((response) => response.json())
            .then((data) => console.log('Petty crime data saved:', data))
            .catch((error) => console.error('Error saving petty crime data:', error));
    };
})();
