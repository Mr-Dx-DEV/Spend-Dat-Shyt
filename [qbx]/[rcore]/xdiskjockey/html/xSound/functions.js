function isReady(soundName){
    const sound = soundList[soundName];
    if(sound == null) { return; }
    if (sound.loaded() == false) {
    	sound.setLoaded(true);

    	const time = sound.audioElement.duration;
    	if (sound.isDynamic()) sound.setVolume(0);
    	if (!sound.isDynamic()) sound.setVolume(sound.getVolume());

    	$.post('https://xdiskjockey/data_status', JSON.stringify({
    		time: time,
    		type: "maxDuration",
    		id: sound.getName(),
    	}));

    	$.post('https://xdiskjockey/events', JSON.stringify({
    		type: "onPlay",
    		id: sound.getName(),
    	}));

    	if (!sound.isYoutube) {
    		sound.isYoutubeReady(true);
    	}

    	addToCache();
    	updateVolumeSounds();
    }
}

function ended(soundName){
    const sound = soundList[soundName];
    if(sound == null) { return; }
    if (!sound.isPlaying()) {
    	if (sound.isLoop()) {
    		const time = sound.audioElement.duration;

            sound.setTimeStamp(0);
            sound.play();

    		$.post('https://xdiskjockey/events', JSON.stringify({
    			type: "resetTimeStamp",
    			id: sound.getName(),
    			time: time,
    		}));
    	}

    	$.post('https://xdiskjockey/data_status', JSON.stringify({
    		type: "finished",
    		id: soundName
    	}));
    	$.post('https://xdiskjockey/events', JSON.stringify({
    		type: "onEnd",
    		id: sound.getName(),
    	}));
    }
}

function getYoutubeUrlId(url)
{
    let videoId = "";
    if( url.indexOf("youtube") !== -1 ){
        let urlParts = url.split("?v=");
        videoId = urlParts[1].substring(0,11);
    }

    if( url.indexOf("youtu.be") !== -1 ){
        let urlParts = url.replace("//", "").split("/");
        videoId = urlParts[1].substring(0,11);
    }
    return videoId;
}

function GetDataFromURL(URL, cb) {
    URL = SanitizeURL(URL);
    const ytId = getYoutubeUrlId(URL);
    if (ytId === "") {
        let audioPlayer = new Audio(URL);
        audioPlayer.loop = false;
        audioPlayer.autoplay = false;
        audioPlayer.volume = 0.0;

        const cleanup = () => {
            if(audioPlayer){
                audioPlayer.pause();
                audioPlayer.src = "";
                audioPlayer.load();
                audioPlayer.onloadedmetadata = null;
                audioPlayer.onerror = null;
                audioPlayer = null;
            }
        }

        audioPlayer.onloadedmetadata = function() {
            cb(editString(URL), audioPlayer.duration, true);
            cleanup();
        };

        audioPlayer.onerror = function(event) {
            cb(null, null, false);
            cleanup();
        };
    }
    else
    {
        ValidYoutubeVideo(ytId, function(result) {
            if (result) {
                var test = new YT.Player("trash", {
                    height: '0',
                    width: '0',
                    videoId: ytId,
                    events: {
                        'onReady': function(event) {
                            cb(event.target.getVideoData().title, test.getDuration(), true);
                            test.stopVideo();
                            test.destroy();
                        },
                    }
                });
            } else {
                cb(null, null, false);
            }
        });
    }
}

function ValidYoutubeVideo(id, cb) {
    fetch("https://img.youtube.com/vi/" + id + "/mqdefault.jpg", { method: 'HEAD' }).then(res => {
        if(res.status == 404){
            cb(false)
            }else{
            cb(true)
        }
    }).catch(err => cb(false));
}

function editString(string){
    return  string.split("/").pop().replace(/\.(mp3|wav|wma|wmv|aac|ac3|aif|ogg)/, " ").replace(/%20|[-_]/g, " ");
}

function SanitizeURL(UserURL) {
    // This DOMPurify + replace should be useless with the code thats below
    // but honestly this is just for my sanity to make double sure.
    UserURL = DOMPurify.sanitize(UserURL);
    UserURL = UserURL.replace(/<[^>]*>?/gm, '');

    const allowedProtocols = new Set([ "http:", "https:" ]);

    try {
        const url = new URL(UserURL);
        if (allowedProtocols.has(url.protocol)) {
            return url.href;
        }
    } catch (error) {
        console.log("UserURL:", UserURL)
        console.log(error);
    }
    return "";
}