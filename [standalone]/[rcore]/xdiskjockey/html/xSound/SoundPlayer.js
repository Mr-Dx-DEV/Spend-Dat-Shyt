let identifierCounterVariable = 0;

class SoundPlayer
{
    static yPlayer = null;
    youtubeIsReady = false;
    pulseSwitch = false;
    stereoSwitch = false;
    pulseTimer = null;
    stereoTimer = null;
    lowpassEffect = null;
    lerpPulseTimer = {};
    
	constructor()
	{
		this.url = "test";
		this.name = "";
		this.dynamic = false;
		this.distance = 10;
		this.volume = 1.0;
		this.pos = [0.0,0.0,0.0];
		this.max_volume = -1.0;
		this.max_volume_before_puls = 0.0;
		this.div_id = "myAudio_" + identifierCounterVariable++;
		this.loop = false;
		this.isYoutube = false;
		this.load = false;
		this.isMuted_ = false;
		this.audioPlayer = null;
		
        this.audioContext = new (window.AudioContext || window.webkitAudioContext)();
        this.audioElementSource = null;
        this.audioElement = null;
	}

	isYoutubeReady(result){
	    this.youtubeIsReady = result;
	}

	getDistance() { return this.distance;}
	getLocation() { return this.pos;     }
	getVolume()   { return this.volume;  }
	getMaxVolume(){ return this.max_volume;  }
	getUrlSound() { return this.url;     }
	isDynamic()   { return this.dynamic; }
	getDivId()    { return this.div_id;  }
	isLoop()      { return this.loop;    }
	getName()     { return this.name;    }
	loaded()      { return this.load;    }

	getAudioPlayer()    { return this.audioPlayer; }
	getYoutubePlayer()  { return this.yPlayer;     }

    setLoaded(result)    { this.load = result;   }
	setName(result)      { this.name = result;   }
	setDistance(result)  { this.distance = result;   }
	setDynamic(result)   { this.dynamic = result;    }
	setLocation(x_,y_,z_){ this.pos = [x_,y_,z_];    }

    clearTimer(id) {
        if (this.lerpPulseTimer[id]) {
            cancelAnimationFrame(this.lerpPulseTimer[id]);
            delete this.lerpPulseTimer[id];
        }
    }

    destroyPulseTimer = () => {
        this.clearTimer("pulse");
        if (this.pulseTimer) {
            clearInterval(this.pulseTimer);
            this.pulseTimer = null;
            this.max_volume = this.max_volume_before_puls;
        }
    }

    destroyStereoTimer = () => {
        this.clearTimer("stereo");
        if (this.stereoTimer) {
            clearInterval(this.stereoTimer);
            this.stereoTimer = null;
        }
        this.setStereo(0);
    }

    lerp(startValue, endValue, time, cb, id, deleteTimer) {
        this.clearTimer(id);
        let t = 0;
        const changeValue = endValue - startValue;
        const step = () => {
            t += 10 / time;
            const currentValue = t >= 1 ? endValue : startValue + changeValue * t;
            cb(currentValue);
            if (t < 1) {
                this.lerpPulseTimer[id] = requestAnimationFrame(step);
            } else if (deleteTimer) {
                this.clearTimer(id);
            }
        };
        this.lerpPulseTimer[id] = requestAnimationFrame(step);
    }

    lerpStereo = (time) => {
        this.stereoSwitch = !this.stereoSwitch;
        const startValue = this.stereoSwitch ? 0.8 : -0.8;
        const endValue = this.stereoSwitch ? -0.8 : 0.8;
        this.lerp(startValue, endValue, time / 2, this.setStereo, "stereo");
    }

    startStereoSound = (time) => {
        this.clearTimer("stereo");
        this.clearTimer("temporary_stereo");

        const intervalTime = time / 2;
        this.lerp(0, 1.0, intervalTime, this.setStereo, "temporary_stereo", true);
        this.stereoTimer = setInterval(() => {
            this.lerpStereo(intervalTime);
        }, intervalTime);
    }

    lerpVolume(percentage, time) {
        this.pulseSwitch = !this.pulseSwitch;
        const startVolume = this.pulseSwitch ? this.max_volume : this.max_volume * percentage;
        const endVolume = this.pulseSwitch ? this.max_volume * percentage : this.max_volume_before_puls;

        this.lerp(startVolume, endVolume, time / 2, this.setMaxVolume, "pulse");
    }

    startPulsingSound = (percentage, time) => {
        this.destroyPulseTimer();
        this.max_volume_before_puls = this.max_volume;

        const adjustedPercentage = (100 - percentage) / 100;
        const intervalTime = time / 2;
        this.lerpVolume(adjustedPercentage, intervalTime);

        this.pulseTimer = setInterval(() => {
            this.lerpVolume(adjustedPercentage, intervalTime);
        }, intervalTime);
    }

	setSoundUrl(result) {
	    this.url = SanitizeURL(result);
	}

    setLoop(result) {
        this.loop = result;
    }


	setMaxVolume = (result) => { this.max_volume = result; }
    setVolume(result) {
        this.volume = result;
        if (this.max_volume == -1) this.max_volume = result;
        if (this.max_volume > (this.volume - 0.01)) this.volume = this.max_volume;
        if (this.isMuted_) {
            if (this.audioElement != null) this.audioElement.volume = 0;
        } else {
            if (this.audioElement != null) this.audioElement.volume = result;
        }
    }

    create() {
        $.post('https://xdiskjockey/events', JSON.stringify({
            type: "onLoading",
            id: this.getName(),
        }));
        const link = getYoutubeUrlId(this.getUrlSound());
        if (link === "") {
            this.isYoutube = false;
            this.audioElement = new Audio(this.getUrlSound());
            this.audioElement.loop = false;
            this.audioElement.autoplay = false;
            this.audioElement.volume = 0.00;
            this.audioElement.onended = () => {
                ended(this.getName());
            };

            this.audioElement.onplay = () => {
                this.audioElementSource = this.audioContext.createMediaElementSource(this.audioElement);
                this.initializeAudioGraph();
            };

            this.audioElement.onloadedmetadata = () => {
                isReady(this.getName());
            };
        } else {
            this.isYoutube = true;
            this.isYoutubeReady(false);
            $("#" + this.div_id).remove();
            $("body").append("<div id='"+ this.div_id +"'></div>");

            this.yPlayer = new YT.Player(this.div_id, {
                videoId: link,
                origin: window.location.href,
                enablejsapi: 1,
                width: "0",
                height: "0",
                playerVars: {
                    autoplay: 1,
                    controls: 0,
                    quality: 'auto',
                },
                events: {
                    "onReady": (event) => {
                        event.target.setVolume(0);
                        event.target.playVideo();
                    },
                    "onStateChange": (event) => {
                        if (event.data == YT.PlayerState.PLAYING && this.youtubeIsReady == false) {
                            const iframe = document.getElementById(this.div_id);
                            const iframeDocument = iframe.contentDocument || iframe.contentWindow.document;

                            const interval = setInterval(() => {
                                this.audioElement = iframeDocument.querySelector("video");
                                if (this.audioElement !== null) {
                                    clearInterval(interval);
                                    if(this.audioElementSource == null){
                                        this.audioElementSource = this.audioContext.createMediaElementSource(this.audioElement);
                                        this.initializeAudioGraph();
                                        isReady(this.getName());
                                        this.audioElement.autoplay = false;
                                        this.audioElement.loop = false;

                                        this.audioElement.onended = () => {
                                            ended(this.getName());
                                        };
                                    }
                                }
                            }, 50);
                        }
                    }
                }
            });
        }
    }

    destroyYoutubeApi() {
        if (this.yPlayer) {
            if (typeof this.yPlayer.stopVideo === "function") {
                try {
                    this.yPlayer.stopVideo();
                } catch (err) {
                    console.error("stopVideo error:", err);
                }
            }
            if (typeof this.yPlayer.destroy === "function") {
                try {
                    this.yPlayer.destroy();
                } catch (err) {
                    console.error("destroy error:", err);
                }
            }
            this.youtubeIsReady = false;
            this.yPlayer = null;
        }
        $("#" + this.div_id).remove();
    }

    getAudioContext(){
        return this.audioElementSource;
    }

    delete() {
        if (this.audioElement) {
            this.audioElement.pause();
            this.audioElement.onplay = null;
            this.audioElement.onended = null;
            this.audioElement.onerror = null;
            this.audioElement.onloadedmetadata = null;
            this.audioElement.src = "";
            this.audioElement.load();
        }

        if (this.audioSource) {
            this.audioSource.disconnect();
            this.audioSource = null;
        }
        if (this.lowpassEffect) {
            this.lowpassEffect.disconnect();
            this.lowpassEffect = null;
        }

        if (this.audioContext && this.audioContext.state !== 'closed') {
            this.audioContext.close().then(() => {
                this.audioContext = null;
            });
        }

        this.audioElement = null;
        this.yPlayer = null;
        $("#" + this.div_id).remove();
    }

    updateVolume(dd, maxd) {
        const d_max = maxd;
        const d_now = dd;
        let vol = 0;
        let distance = (d_now / d_max);
        if (distance < 1) {
            distance = distance * 100;
            const far_away = 100 - distance;
            vol = (this.max_volume / 100) * far_away;
            this.setVolume(vol);
            this.isMuted_ = false;
        } else {
            this.setVolume(0);
            this.isMuted_ = true;
        }
    }

    play() {
        if (this.audioElement) {
            this.audioElement.play();
        }
    }

    pause() {
        if (this.audioElement) {
            this.audioElement.pause();
        }
    }

    resume() {
        if (this.audioElement) {
            this.audioElement.play();
        }
    }

    isMuted() {
        return this.isMuted_;
    }

    mute() {
        this.setVolume(0);
        this.isMuted_ = true;
    }

	unmute()
	{
	    this.setVolume(this.getVolume())
        this.isMuted_ = false;
	}

	unmuteSilent()
	{
        this.isMuted_ = false;
	}

    setTimeStamp(time) {
        if (this.audioElement) {
            this.audioElement.currentTime = time;
        }
    }

    isPlaying() {
        return !this.audioElement.paused && this.audioElement.currentTime > 0 && !this.audioElement.ended;
    }

    initializeAudioGraph() {
        if (!this.lowpassEffect && !this.stereoPanner) {
            this.lowpassEffect = this.audioContext.createBiquadFilter();
            this.stereoPanner = this.audioContext.createStereoPanner();

            this.lowpassEffect.frequency.value = 17500;
            this.audioElementSource.connect(this.lowpassEffect);
            this.lowpassEffect.connect(this.stereoPanner);
            this.stereoPanner.connect(this.audioContext.destination);
        }
    }

    enableLowpass() {
        this.lowpassEffect.frequency.linearRampToValueAtTime(intensityLowPass, this.audioContext.currentTime + 0.3);
    }

    disableLowpass() {
        this.lerp(this.lowpassEffect.frequency.value, 17500, 300, (value) => {
            this.lowpassEffect.frequency.linearRampToValueAtTime(value, this.audioContext.currentTime);
        }, "temporary_lowpass_timer", true);
    }

    setStereo = (pan) => {
        if(this.stereoPanner){
            if (pan >= -1 && pan <= 1) {
                this.stereoPanner.pan.value = pan;
            }
        }
    }
}