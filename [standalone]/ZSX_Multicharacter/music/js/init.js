const getResourceCallbackBase = () => {
    const host = window.location.host || ''
    const resourceName = host.replace(/^cfx-nui-/, '')
    return `https://${resourceName}`
}

let Config = {
    UseNewLogic: true,
    URL: false,
    ShowDebug: false,
    TargetCallbackURL: getResourceCallbackBase(),

    Heartbeat: {
      Interval: 1000,
      CheckDuration: 2000
    }
}

let Storage = {
    videoId: false,
    volume: 10.0,

    setVolume(_volume) {
        this.volume = _volume
    },

    setVideoId(_videoId) {
        this.videoId = _videoId
    }
}

const postNui = (url, payload) => {
    const body = typeof payload === 'string' ? payload : JSON.stringify(payload || {})

    try {
        if (window.$ && typeof $.post === 'function') {
            $.post(url, body)
            return
        }
    } catch(e) {}

    try {
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body
        }).catch(() => {})
    } catch(e) {}
}

const Debug = {
    _send(level, message) {
        try {
            const rawBase = (Config && (Config.TargetURL || Config.TargetCallbackURL))
                ? (Config.TargetURL || Config.TargetCallbackURL)
                : getResourceCallbackBase()
            const base = rawBase.replace(/\/+$/, '') // strip trailing slashes to prevent double-slash URLs
            postNui(`${base}/musicTest.log`, { level: level, message: message })
        } catch(e) {}
    },
    error(message) {
        if (!Config.ShowDebug) return
        this._send('error', message)
    },
    log(message) {
        if (!Config.ShowDebug) return
        this._send('log', message)
    }
}
