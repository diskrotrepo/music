<template>
  <div class="content">
    <div class="column left">
      <Create @submit="submitForm" />
      <p v-if="generatingMusic" class="response">{{ generatingMusic }}</p>

      <audio v-if="taskId && !generatingMusic" controls>
        <source :src="`${soundFile}`" type="audio/wav" />
        Your browser does not support the audio element.
      </audio>
    </div>
    <div class="column right">
      <Library v-if="!loading && !error" :songs="songs" />
    </div>
  </div>
</template>

<script>
import { ref, onMounted, watch } from 'vue'
import Library from '../components/Library.vue'
import configuration from '../../config/configuration.json'


export default {
  components: {
    Library
  },
  setup() {
    const songs = ref([])
    const loading = ref(true)
    const error = ref(null)
    const listView = ref('library') // Default: show library
    const showFavorites = ref(false) // Default: show all songs

    const fetchSongs = async () => {
      loading.value = true
      error.value = null

      try {
        let url = `${configuration.api}/library?list_view=${listView.value}`
        if (showFavorites.value) {
          url += '&favorite=true' // Apply favorite filter if toggled on
        }

        const response = await fetch(url)
        if (!response.ok) {
          throw new Error('No songs found.')
        }
        const data = await response.json()
        songs.value = data.library || []
      } catch (err) {
        error.value = err.message
      } finally {
        loading.value = false
      }
    }

    // Toggle between "library" and "trash"
    const toggleListView = () => {
      listView.value = listView.value === 'library' ? 'trash' : 'library'
    }

    // Toggle between "favorites" and "all songs"
    const toggleFavorite = () => {
      showFavorites.value = !showFavorites.value
    }

    // Fetch songs when listView or showFavorites changes
    watch([listView, showFavorites], fetchSongs)

    onMounted(fetchSongs)

    return {
      songs,
      loading,
      error,
      listView,
      showFavorites,
      toggleListView,
      toggleFavorite
    }
  }
}
</script>

<style scoped>

.content {
  display: flex;
  height: 100vh;
  width: 100%;
}

.column {
  display: flex;
  flex-direction: column;
}

.column.left {
  flex: 0 0 500px; 
  overflow: hidden;
  background-color: blue;
}

.column.right {
  flex: 0 0 auto;  
  overflow-y: auto;
  width: 100%;
  background-color: red;
}

</style>