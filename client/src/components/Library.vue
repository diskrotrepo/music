<template>
    <div class="library">
      
      <ul v-if="songs.length" class="space-y-4">
        <li
          v-for="song in songs"
          :key="song.lrc_id"
          class="p-4 border rounded-lg shadow-md bg-white"
        >
          <h3 class="text-lg font-semibold">{{ song.title }}</h3>
          <p class="text-gray-600">Duration: {{ song.duration }}s</p>
          <p class="text-gray-500">Tags: {{ song.tags }}</p>
          <p v-if="song.negative_tags" class="text-red-500">
            Negative Tags: {{ song.negative_tags }}
          </p>
          <p class="text-gray-400 text-sm">
            Created: {{ formatDate(song.dt_created) }}
          </p>
          <p>
            <audio controls>
              <source :src="`http://127.0.0.1:5000/static/music/${song.filename}`" type="audio/wav">
                Your browser does not support the audio element.
              </audio>
          </p>
          <p>
            <button @click="song.is_favorite ? unfavoriteSong(song.id) : favoriteSong(song.id)">
              {{ song.is_favorite ? "Unfavorite" : "Favorite" }}
            </button>
            <button @click="song.is_deleted ? restoreSong(song.id) : deleteSong(song.id)">
              {{ song.is_deleted ? "Restore" : "Delete" }}
            </button>
            </p>
        </li>
      </ul>
      <p v-else class="text-gray-500">No songs found.</p>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      songs: {
        type: Array,
        required: true,
      },
    },
    methods: {
      formatDate(date) {
        return date ? new Date(date).toLocaleString() : "Unknown";
      },
        async favoriteSong(id) {
          const response = await fetch(`http://127.0.0.1:5000/api/v1/library/song/${id}/action/favorite`,{
            method: 'POST',
          });
          if (!response.ok) {
            throw new Error("Could not favorite song");
          }
        },

        async deleteSong(id) {
          const response = await fetch(`http://127.0.0.1:5000/api/v1/library/song/${id}/action/delete`,{
            method: 'POST',
          });
          if (!response.ok) {
            throw new Error("Could not delete song");
          }
        },
        async unfavoriteSong(id) {
          const response = await fetch(`http://127.0.0.1:5000/api/v1/library/song/${id}/action/unfavorite`,{
            method: 'POST',
          });
          if (!response.ok) {
            throw new Error("Could not unfavorite song");
          }
        },
        async restoreSong(id) {
          const response = await fetch(`http://127.0.0.1:5000/api/v1/library/song/${id}/action/restore`,{
            method: 'POST',
          });
          if (!response.ok) {
            throw new Error("Could not restore song");
          }
        }
    },
  };
  </script>
  
  <style scoped>
  .library {
    max-width: 600px;
    margin: auto;
  }
  </style>
  