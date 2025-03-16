<template>
  <div class="library">
    <ul v-if="songs.length">
      <li v-for="song in songs" :key="song.lrc_id" >
        <div class="song">
          <span class="song-left">
            <span class="song-title">{{ song.title }}</span>
              <div class="song-tags"><b>Tags</b> {{ song.tags }}</div> 
          </span>
          <span class="song-right">
            <button @click="song.is_favorite ? unfavoriteSong(song.id) : favoriteSong(song.id)">
          <i class="fa-regular fa-heart icon"></i>
        </button>
        <button @click="song.is_deleted ? restoreSong(song.id) : deleteSong(song.id)">
          <i class="fa-solid fa-trash icon"></i>
        </button>
          </span>
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
        {
          method: 'POST'
        }
      )
      if (!response.ok) {
        throw new Error('Could not favorite song')
      }
    },

    async deleteSong(id) {
      const response = await fetch(
        `${configuration.api}/library/song/${id}/action/delete`,
        {
          method: 'POST'
        }
      )
      if (!response.ok) {
        throw new Error('Could not delete song')
      }
    },
    async unfavoriteSong(id) {
      const response = await fetch(
        `${configuration.api}/library/song/${id}/action/unfavorite`,
        {
          method: 'POST'
        }
      )
      if (!response.ok) {
        throw new Error('Could not unfavorite song')
      }
    },
    async restoreSong(id) {
      const response = await fetch(
        `${configuration.api}/library/song/${id}/action/restore`,
        {
          method: 'POST'
        }
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
  width: 800px;
  color: white;
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

.song {
  background-color: rgb(32, 32, 38);
  margin-bottom: 10px;
  padding: 10px;
  width: 490px;
  height: 70px;
  border-radius: .8em;
}

.song-title {
  font-size: 1.1em;
  font-weight: bold;
}

.song-left {
  float: left;
  width: 75%;
}

.song-right {
  float: right;
  width: 25%;
  top: 30%;
  position: relative;
}
</style>
