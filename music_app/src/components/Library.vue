<template>
  <div class="library">
    <ul v-if="songs.length">
      <li v-for="song in songs" :key="song.lrc_id">

        <div class="song" :class="{ loading: song.processing_status }" @click="playSong(song)">
          <div class="song-left">
            <span class="song-title">{{ song.title }}</span>
            <div class="song-tags"><b>Tags</b> {{ song.tags }}</div>
          </div>
          <div class="song-generating" v-if="song.processing_status === 'COMPLETE'">
            generating song
          </div>
          
          <div class="progress-bar" v-if="song.processing_status === 'COMPLETE'"></div>
        </div>
      </li>
    </ul>
    <p v-else class="text-gray-500">No songs found.</p>
  </div>
</template>

<script>
import configuration from '../../config/configuration.json'
import { usePlayerStore } from '../stores/playerStore'

export default {
  props: {
    songs: {
      type: Array,
      required: true
    }
  },
  methods: {
    playSong(song) {
      song.title = "The summer is warming, the summer is";
      song.filename = "https://cdn1.suno.ai/c4aa166f-6a12-4d68-89d0-6ecb3c7c375f.mp3";
      const playerStore = usePlayerStore();
      playerStore.setCurrentSong(song);
    },
    formatDate(date) {
      return date ? new Date(date).toLocaleString() : 'Unknown'
    },
    async favoriteSong(id) {
      const response = await fetch(
        `${configuration.api}/library/song/${id}/action/favorite`,
        { method: 'POST' }
      )
      if (!response.ok) {
        throw new Error('Could not favorite song')
      }
    },
    async deleteSong(id) {
      const response = await fetch(
        `${configuration.api}/library/song/${id}/action/delete`,
        { method: 'POST' }
      )
      if (!response.ok) {
        throw new Error('Could not delete song')
      }
    },
    async unfavoriteSong(id) {
      const response = await fetch(
        `${configuration.api}/library/song/${id}/action/unfavorite`,
        { method: 'POST' }
      )
      if (!response.ok) {
        throw new Error('Could not unfavorite song')
      }
    },
    async restoreSong(id) {
      const response = await fetch(
        `${configuration.api}/library/song/${id}/action/restore`,
        { method: 'POST' }
      )
      if (!response.ok) {
        throw new Error('Could not restore song')
      }
    }
  }
}
</script>

<style scoped>
.library {
  color: white;
}

.song {
  background-color: rgb(32, 32, 38);
  margin-bottom: 10px;
  padding: 8px;
  border-radius: 0.8em;
  position: relative; 
  width: 500px;
}

.song:hover {
  background-color: rgba(128, 47, 128, 0.15);
}

.song-title {
  font-size: 1.1em;
  font-weight: bold;
}

button {
  background: none;
  border: none;
  cursor: pointer;
}

.icon {
  color: white;
}

li {
  list-style: none;
}

/* Optional: additional loading styling */
.loading {
  border: 2px rgb(252, 107, 233) dashed;
}

/* Progress bar styles */
.progress-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  height: 100%;
  background-color: rgba(255, 255, 255, 0.05); /* Change this to your preferred color */
  animation: progressAnimation 2s linear infinite;
}

@keyframes progressAnimation {
  0% { width: 0%; }
  100% { width: 100%; }
}

.song-generating {
  text-align: center;
  font-weight: bold;
  background-color: rgb(189, 85, 174);
  border-radius: 0.4em;
  font-size: 0.8em;
}
</style>
