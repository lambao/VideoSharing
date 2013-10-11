function onYouTubePlayerReady() {
    alert("hehi");
    ytplayer = document.getElementById("ytplayer");
    ytplayer.addEventListener("onStateChange", "onytplayerStateChange");
}

function onytplayerStateChange(newState) {
    alert("Player's new state: " + newState);
}
