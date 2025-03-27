<template>
  <div class="content">
    <span class="player">
      <audio ref="audioPlayer" :src="currentSong ? currentSong.filename : ''"></audio>
      <span class="song-title">
        {{ currentSong ? currentSong.title : 'No song playing' }}
      </span>
      <span class="player-controls">
        <button @click="previousSong">
          <i class="fa-solid fa-backward-step player-ui-element"></i>
        </button>
        <button @click="handlePlayer">
          <i v-if="isPlaying" class="fa-solid fa-pause player-ui-element"></i>
          <i v-else class="fa-solid fa-play player-ui-element"></i>
        </button>
        <button @click="nextSong">
          <i class="fa-solid fa-forward-step player-ui-element"></i>
        </button>
       
        {{ formattedCurrentTime }} / {{ formattedDuration }}
      </span>
      <span class="player-srubber"></span>
    </span>
  </div>
</template>

<script>
import { usePlayerStore } from '../stores/playerStore'
import { ref, computed, watch, onMounted, onUnmounted } from 'vue'

export default {
  setup() {
    const playerStore = usePlayerStore()
    const currentSong = computed(() => playerStore.currentSong)
    const audioPlayer = ref(null)
    const isPlaying = ref(false)
    const duration = ref(0)
    const currentTime = ref(0)
    const playHistory = ref([])
    const playHistoryIdx = ref(0)

    const handlePlayer = () => {
      if (!audioPlayer.value) return
      if (isPlaying.value) {
        audioPlayer.value.pause()
        isPlaying.value = false
      } else {
        audioPlayer.value.play()
          .then(() => {
            isPlaying.value = true
          })
          .catch((err) => {
            console.error('Error playing audio:', err)
          })
      }
    }

    const previousSong = () => {
      if (!audioPlayer.value) return
     
      if (audioPlayer.value.currentTime > 1) {
        audioPlayer.value.currentTime = 0
      } else {
        
       playerStore.currentSong = playHistory[playHistory.value.length - 1];
      }
     
    }
    const nextSong = () => {
      if (!audioPlayer.value) return


     
    }

    const formatTime = (time) => {
      if (isNaN(time)) return "00:00"
      const minutes = Math.floor(time / 60)
      const seconds = Math.floor(time % 60)
      return `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`
    }

    const formattedCurrentTime = computed(() => formatTime(currentTime.value))
    const formattedDuration = computed(() => formatTime(duration.value))

    const onLoadedMetadata = () => {
      duration.value = audioPlayer.value.duration
    }
    const onTimeUpdate = () => {
      currentTime.value = audioPlayer.value.currentTime
    }

    onMounted(() => {
      if (audioPlayer.value) {
        audioPlayer.value.addEventListener('loadedmetadata', onLoadedMetadata)
        audioPlayer.value.addEventListener('timeupdate', onTimeUpdate)
      }
    })

    onUnmounted(() => {
      if (audioPlayer.value) {
        audioPlayer.value.removeEventListener('loadedmetadata', onLoadedMetadata)
        audioPlayer.value.removeEventListener('timeupdate', onTimeUpdate)
      }
    })

    watch(currentSong, (newSong) => {
      if (newSong && audioPlayer.value) {
        playHistory.value.push(newSong);
        

        audioPlayer.value.load();
        audioPlayer.value.play();
        isPlaying.value = true;
      }
    })

    return { 
      currentSong, 
      audioPlayer, 
      isPlaying, 
      handlePlayer, 
      previousSong, 
      nextSong, 
      formattedCurrentTime, 
      formattedDuration 
    }
  },
}
</script>

<style scoped>
.player {
  left: 0px;
}

.song-title {
  font-size: 1.2em;
  margin: 0 10px 0 20px;
  color: white;
}

.player-controls {
  position: absolute;
  top: 5px;
  width: 100%;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
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
  cursor: pointer;
}

.player-ui-element {
  margin: 0 10px;
  font-size: 1.8em;
  cursor: pointer;
}

.player-ui-element:hover {
  color: rgb(239, 66, 196);
}
</style>
