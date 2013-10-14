function onYouTubePlayerReady() {
    alert("hehi");
    console.log("onYouTubePlayerReady");
    ytplayer = document.getElementById("ytplayer");
    ytplayer.addEventListener("onStateChange", "onytplayerStateChange");
}

function onytplayerStateChange(newState) {
    alert("Player's new state: " + newState);
}

function onYouTubeIframeAPIReady() {
    console.log("onYouTubeIframeAPIReady");
}