<template>
  <div class="content">
    <span class="player">
        <span class="song-title">This is my song title</span>
        <span class="player-controls">
            <button><i class="fa-solid fa-backward-step player-ui-element"></i></button>
            <button><i class="fa-solid fa-play player-ui-element"></i></button>
            <button><i class="fa-solid fa-forward-step player-ui-element"></i></button>
            02:00 / 04:34
        </span>
        <span class="player-srubber"></span>
    </span>
  </div>
</template>


<style scoped>

.player {
    left: 0px;
}

.song-title {
    font-size: 0.6em;
    margin-right: 10px;
    color: white;
    font-size: 1.2em;
    margin-left: 20px;
}

.player-controls {
    position: absolute;
    top: 5px;
    width: 100%;
    color: white;
    display: flex;
    justify-content: center;
}

.player-controls-small {
   
    padding-left: 20px;
    width: 100%;
    color: white;
    font-size: 1.2em;
}

.player-srubber {
    position: absolute;
    left: 0px;
    width: 100%;
    height: 8px;
    background-color: rgb(207, 38, 192);
    border-radius: 5px;
    bottom: 0px;
    
}

button {
    border: none;
    background-color: transparent;
    color: white;
}

.player-ui-element {
    margin: 0 10px;
    font-size: 1.8em;
    cursor: pointer;
}

</style>