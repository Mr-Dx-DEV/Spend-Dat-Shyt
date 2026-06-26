if (!globalThis.componentsLoaded) {
    globalThis.componentsLoaded = true;

    globalThis.fetchNui = async (event, data, scriptName) => {
        scriptName = scriptName || globalThis.resourceName;

        if (scriptName !== globalThis.resourceName) {
            console.warn(`The app ${appName} (${globalThis.resourceName}) is fetching from another resource (${scriptName}), this will soon be blocked by FiveM. Read more: https://forum.cfx.re/t/5261145`);
        }

        try {
            const response = await fetch(`https://${scriptName}/${event}`, {
                method: 'post',
                body: JSON.stringify(data)
            });

            if (!response.ok) throw new Error(`${response.status} - ${response.statusText}`);

            return await response.json();
        } catch (err) {
            console.error(`Error fetching ${event} from ${scriptName}`, err);
        }
    };

    globalThis.onNuiEvent = (eventName, cb) => {
        window.addEventListener('message', (event) => {
            if (event.data?.action === eventName) {
                cb(event.data.data);
            }
        });
    };

    globalThis.useNuiEvent = globalThis.onNuiEvent;

    let settingsListeners = [];

    globalThis.onNuiEvent('settingsUpdated', (settings) => {
        globalThis.settings = settings;

        settingsListeners.forEach((cb) => cb(settings));
    });

    globalThis.onSettingsChange = (cb) => {
        settingsListeners.push(cb);
    };

    for (const [name, component] of Object.entries(globalThis.components)) {
        globalThis[name] = component;
    }

    globalThis.postMessage('componentsLoaded', '*');
}
