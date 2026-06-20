const DEBUG = true

// ============================================================================
// Manual iframe + postMessage approach.
// new YT.Player() auto-injects origin=nui://... into the embed URL.
// YouTube rejects nui:// as an invalid origin → Error 153.
// By creating the <iframe> ourselves, we control the URL entirely.
// ============================================================================

class YouTubePlayer {
    constructor() {
        this.iframe = null
        this.playerReady = false

        this.volume = 10
        this.playerVolume = 0
        this.targetVideoID = ""

        this.lastPlayerState = "UNKNOWN"

        this.fadeInterval = false
        this.listenRetryInterval = null
        this.listenRetryTimeout = null

        this.YTPlayerStates = {
            '-1': 'UNSTARTED',
            '0': 'ENDED',
            '1': 'PLAYING',
            '2': 'PAUSED',
            '3': 'BUFFERING',
            '5': 'CUED'
        }

        // Listen for postMessage events from the YouTube embed iframe.

        window.addEventListener('message', (event) => {
            if (!event || !event.data) return
            if (!this.iframe || !this.iframe.contentWindow || event.source !== this.iframe.contentWindow) return

            let msg = null
            if (typeof event.data === 'string') {
                try {
                    msg = JSON.parse(event.data)
                } catch(e) {
                    return
                }
            } else if (typeof event.data === 'object') {
                msg = event.data
            }

            if (msg && msg.event) this._handleYTMessage(msg)
        })
    }

    // ── YouTube embed postMessage handlers ─────────────────────────────────

    _handleYTMessage(msg) {
        if (msg.event === 'onReady') {
            Debug.log('_handleYTMessage: onReady from embed')
            this._onPlayerReady()
        } else if (msg.event === 'onStateChange') {
            Debug.log('_handleYTMessage: onStateChange info=' + msg.info)
            this._onStateChange(msg.info)
        } else if (msg.event === 'onError') {
            Debug.error('_handleYTMessage: YouTube Error code=' + msg.info)
        } else if (msg.event === 'infoDelivery' && msg.info && msg.info.playerState !== undefined) {
            // YouTube sends periodic info updates — detect state changes from these too
            const mapped = this.YTPlayerStates['' + msg.info.playerState]
            if (mapped && mapped !== this.lastPlayerState) {
                Debug.log('_handleYTMessage: infoDelivery state=' + msg.info.playerState)
                this._onStateChange(msg.info.playerState)
            }
        } else if (msg.event === 'infoDelivery' && msg.info && msg.info.volume !== undefined) {
            this.playerVolume = msg.info.volume
        }
    }

    _onPlayerReady() {
        this._clearListeningRetries()
        this.setPlayerAsReady(true)
        Debug.log('YT Player is ready! (manual iframe)')

        const targetBaseURL = Config.TargetURL || Config.TargetCallbackURL
        postNui(`${targetBaseURL}/musicPlayer.player.ready`, {})

        this._cmd('unMute', [])
        this._cmd('setVolume', [0])
        this.play()
    }

    _onStateChange(stateNum) {
        const mapped = this.YTPlayerStates['' + stateNum] || 'UNKNOWN'
        Debug.log(`>>> onStateChange FIRED: raw=${stateNum} mapped=${mapped}`)
        this.updatePlayerState(mapped)
    }

    // ── Send a command to the YouTube embed via postMessage ────────────────

    _cmd(func, args) {
        if (!this.iframe || !this.iframe.contentWindow) {
            Debug.error('_cmd(' + func + '): no iframe or contentWindow')
            return false
        }
        try {
            
            this.iframe.contentWindow.postMessage(JSON.stringify({
                event: 'command',
                func: func,
                args: args || []
            }), '*')
            return true
        } catch(e) {
            Debug.error('_cmd(' + func + ') error: ' + e.message)
            return false
        }
    }

    // Tell the YouTube embed to start sending us events
    _startListening() {
        if (!this.iframe || !this.iframe.contentWindow) return
        this.iframe.contentWindow.postMessage(JSON.stringify({
            event: 'listening',
            id: 1,
            channel: 'widget'
        }), '*')
        Debug.log('_startListening: registered for embed events')
    }

    _clearListeningRetries() {
        if (this.listenRetryInterval) {
            clearInterval(this.listenRetryInterval)
            this.listenRetryInterval = null
        }
        if (this.listenRetryTimeout) {
            clearTimeout(this.listenRetryTimeout)
            this.listenRetryTimeout = null
        }
    }

    // ── Create / Destroy ──────────────────────────────────────────────────

    createPlayer() {
        const container = document.querySelector('.pre-yt')
        if (!container) {
            Debug.error('createPlayer: .pre-yt container not found!')
            return
        }

        // Remove any existing element
        const old = document.getElementById('youtube')
        if (old) old.remove()

        const videoId = this.targetVideoID || this.extractVideoId(Config.URL)
        Debug.log('createPlayer: manual iframe for videoId=' + videoId)

        // Build the iframe ourselves — NO nui:// origin.
        // The DUI page now loads from https://cfx-nui-resourceName/ which is valid HTTPS.
        // We set origin= to match so YouTube's postMessage events work correctly.
        const pageOrigin = window.location.origin || ('https://' + window.location.host)
        const iframe = document.createElement('iframe')
        iframe.id = 'youtube'
        iframe.style.cssText = 'width:100%;height:100%;border:none;position:absolute;left:0;top:0;'
        iframe.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
        iframe.setAttribute('allowfullscreen', '')
        iframe.src = 'https://www.youtube.com/embed/' + videoId
            + '?autoplay=0&enablejsapi=1&controls=0&mute=1&rel=0&fs=0&modestbranding=1&widgetid=1'
            + '&origin=' + encodeURIComponent(pageOrigin)

        Debug.log('createPlayer: iframe src=' + iframe.src)
        Debug.log('createPlayer: page origin=' + pageOrigin)

        this.iframe = iframe

        iframe.addEventListener('load', () => {
            Debug.log('createPlayer: iframe onload fired')

            this._clearListeningRetries()
            this._startListening()

            // TODO: Tune this interval, may be a issue, may never be. Need to figure out a good middle ground for catching state.
            this.listenRetryInterval = setInterval(() => {
                if (!this.iframe || this.iframe !== iframe || this.playerReady) {
                    this._clearListeningRetries()
                    return
                }
                this._startListening()
            }, 250)

            this.listenRetryTimeout = setTimeout(() => {
                this._clearListeningRetries()
                if (!this.playerReady && this.iframe === iframe) {
                    Debug.log('createPlayer: onReady timeout — forcing ready state')
                    this._onPlayerReady()
                }
            }, 4000)
        })

        container.appendChild(iframe)
    }

    destroyPlayer() {
        const targetBaseURL = Config.TargetURL || Config.TargetCallbackURL
        postNui(`${targetBaseURL}/musicPlayerDUI.player.onRemove`, {});
        this._clearListeningRetries()
        if (this.iframe) {
            this.iframe.remove()
            this.iframe = null
        }

        this.setPlayerAsReady(false)
        Debug.log('destroyPlayer: iframe removed from DOM')
    }

    setPlayerAsReady(state) {
        this.playerReady = state
    }

    getIsPlayerReady() {
        return this.playerReady
    }

    validatePlayer() {
        return this.iframe !== null
    }

    validatePlayerFunction(_func) {
        // In manual iframe mode, commands are sent via postMessage — always valid if iframe exists
        return this.iframe !== null && this.iframe.contentWindow !== null
    }

    updatePlayerState(_state) {
        const lastRecordedState = this.lastPlayerState
        this.lastPlayerState = _state

        const targetBaseURL = Config.TargetURL || Config.TargetCallbackURL
        postNui(`${targetBaseURL}/musicPlayerDUI_playerStatusUpdate`, {
            lastState: lastRecordedState,
            state: this.lastPlayerState
        });

        this.handlePlayerStateChange()
    }

    handlePlayerStateChange() {
        const STATE = this.lastPlayerState
        switch (STATE) {
            case 'UNSTARTED':
                // Initial state, or after stopVideo/destroy. Nothing to do.
                Debug.log(`UNSTARTED — targetVideoID=${this.targetVideoID} playerReady=${this.playerReady}`)
                break
            case 'ENDED':
                this.play()
                break
            case 'PLAYING':
                Debug.log(`handlePlayerStateChange PLAYING — targetVideoID=${this.targetVideoID}`)
                // When playback starts, ensure audio is enabled and at the right volume.
                // Route metadata fetch through the Lua server to avoid CEF CORS restrictions.
                if (this.targetVideoID) {
                    const targetBaseURL = Config.TargetURL || Config.TargetCallbackURL
                    Debug.log(`Posting metadata request for ${this.targetVideoID} to ${targetBaseURL}`)
                    postNui(`${targetBaseURL}/musicPlayer.requestMetadata`, {
                        videoId: this.targetVideoID
                    })
                } else {
                    Debug.error('PLAYING fired but targetVideoID is empty — metadata request skipped')
                }
                break
            case 'PAUSED':

                break
            case 'BUFFERING':

                break
            case 'CUED':

                break
            default:
                break
        }
    }

    setURL(_url) {
        const videoId = (_url.includes('youtu.be') || _url.includes('youtube')) ? this.extractVideoId(_url) : _url
        this.targetVideoID = videoId
    }

    changeURL(_url) {
        Debug.log(`changeURL() called — url=${_url} playerReady=${this.playerReady}`)
        if (!this.getIsPlayerReady()) {
            return Debug.error("Can not change the music. YouTube Player is not ready or instance has not been created yet.")
        }

        if (!_url) {
            return Debug.error('Can not change the music. URL is blank.')
        }

        const videoId = (_url.includes('youtu.be') || _url.includes('youtube')) ? this.extractVideoId(_url) : _url
        if (!videoId) {
            return Debug.error('Can not change the music. Video ID could not be extracted.')
        }
        
        Debug.log(`changeURL — destroying player and recreating for videoId=${videoId}`)
        this.destroyPlayer()
        this.targetVideoID = videoId
        this.createPlayer()
    }

    changeTargetVolume(_volume) {
        Debug.log("changing target player volume")
        this.volume = _volume
        this._cmd('setVolume', [_volume])
    }

    fade(targetVolume, duration) {
        if (this.fadeInterval) {
            clearInterval(this.fadeInterval)
            this.fadeInterval = false
        }

        const initialVolume = this.playerVolume
        const interval = 10
        const steps = duration / interval
        const volumeStep = (targetVolume - initialVolume) / steps
        let currentStep = 0

        this.fadeInterval = setInterval(() => {
            if (currentStep < steps) {
                const newVolume = initialVolume + currentStep * volumeStep
                this._cmd('setVolume', [newVolume])
                currentStep++
            } else {
                this._cmd('setVolume', [targetVolume])
                this.volume = targetVolume
                clearInterval(this.fadeInterval)
                this.fadeInterval = false
            }
        }, interval)
    }

    play() {
        Debug.log(`play() called — playerReady=${this.playerReady}`)
        Debug.log('play() — sending playVideo command')
        this._cmd('playVideo', [])
    }

    pause() {
        this._cmd('pauseVideo', [])
    }

    setVolume(_volume) {
        
        Debug.log("changing player volume")
        this.volume = _volume
        if (this.iframe) {
            this._cmd('setVolume', [_volume])
        }
    }

    extractVideoId(_url) {
        const pattern = /(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?&v=|.*[?&]v=))([^?&]+)(?:[?&]|\b)/;
        const match = _url.match(pattern);
        if (match && match[1]) {
            return match[1];
        } else {
            return null;
        }
    }
}
