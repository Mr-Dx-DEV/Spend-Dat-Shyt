window.addEventListener('DOMContentLoaded', () => {
    const callbackBase = (Config.TargetCallbackURL || getResourceCallbackBase()).replace(/\/+$/, '')
    postNui(`${callbackBase}/musicPlayer.bodyLoaded`, {})
    Debug.log('[windowListener] body loaded (callback via ' + callbackBase + ')')

    window.addEventListener('message', (e) => {
        const DUI = e.data
        if (typeof DUI !== 'object' || DUI === null || DUI.message === undefined) return
        if (DUI.message && Config.ShowDebug) Debug.log('[windowListener] DUI message: ' + DUI.message)
        if (DUI.message && methods[DUI.message]) methods[DUI.message](DUI.data)
        else if (DUI.message) Debug.log('[windowListener] no handler for: ' + DUI.message)
    })
})

let _YTPlayer = null

const methods = {
    SEND_CONFIG(_config) {
        Config = _config
        if (Config.TargetCallbackURL) Config.TargetCallbackURL = Config.TargetCallbackURL.replace(/\/+$/, '')
        if (Config.TargetURL)         Config.TargetURL         = Config.TargetURL.replace(/\/+$/, '')

        if (_YTPlayer && _YTPlayer.getIsPlayerReady()) {
            if (Config.ShowDebug) Debug.log('[windowListener] SEND_CONFIG — player already ready, skipping')
            return
        }

        _YTPlayer = new YouTubePlayer()
        _YTPlayer.setURL(Storage.videoId || Config.URL)
        _YTPlayer.setVolume(Storage.volume || Config.Volume || 10)

        // Create the player immediately — no YT API to wait for
        Debug.log('[windowListener] SEND_CONFIG — creating player')
        _YTPlayer.createPlayer()
    },

    SEND_STORAGE(_storage) {
        Storage.setVideoId(_storage.url)
        Storage.setVolume(_storage.volume)
    },

    UPDATE_URL(data) {
        const url = data.url
    },

    HEARTBEAT() {
        const targetBaseURL = (Config.TargetURL || Config.TargetCallbackURL || getResourceCallbackBase()).replace(/\/+$/, '')
        postNui(`${targetBaseURL}/musicPlayerDUI_heartBeatReceived`, {})
    },

    CALL_FADE(data) {
        _YTPlayer.fade(data.targetVolume, data.duration)
    },

    CALL_PLAY() {
        _YTPlayer.play()
    },

    CALL_PAUSE() {
        _YTPlayer.pause()
    },

    CALL_SET_VOLUME(data) {
        _YTPlayer.setVolume(data.volume)
    },

    CALL_CHANGE_MUSIC(data) {
        _YTPlayer.changeURL(data.videoId)
    },
}
