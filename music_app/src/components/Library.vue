<template>
  <div class="library">
    <ul v-if="songs.length">
      <li v-for="song in songs" :key="song.lrc_id">
        <div class="song" :class="{ loading: song.processing_status }">
          <div class="song-left">
            <span class="song-title">{{ song.title }}</span>
            <div class="song-tags"><b>Tags</b> {{ song.tags }}</div>
          </div>
          
          <!-- Only show progress bar when processing_status is truthy -->
          <div class="progress-bar" v-if="song.processing_status"></div>
        </div>
      </li>
    </ul>
    <p v-else class="text-gray-500">No songs found.</p>
  </div>
</template>

<script>
import configuration from '../../config/configuration.json'

export default {
  props: {
    songs: {
      type: Array,
      required: true
    }
  },
  methods: {
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
  flex-basis: 500px;
  background-color: rgb(32, 32, 38);
  margin-bottom: 10px;
  padding: 10px;
  border-radius: 0.8em;
  position: relative; 
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
</style>
