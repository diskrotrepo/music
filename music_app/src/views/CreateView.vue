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
import Create from '../components/Create.vue'
import Library from '../components/Library.vue'
import configuration from '../../config/configuration.json'


export default {
  components: { Create, Library },
  setup() {
    const generatingMusic = ref('')
    const taskId = ref(null)
    const soundFile = ref(null)
    const percentComplete = ref(0)

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

    const pollStatus = async (id, intervalId) => {
      try {
        const response = await fetch(`${configuration.api}/status/${id}`)
        if (!response.ok) throw new Error('Failed to check status.')

        const data = await response.json()
        if (data.processing_status === 'COMPLETE') {
          generatingMusic.value = ''
          soundFile.value = `http://${data.filename}`
          clearInterval(intervalId)
        } else {
          percentComplete.value = percentComplete.value + 5
          generatingMusic.value = `${percentComplete.value}% - Generating music...`
        }
      } catch (e) {
        console.error(e)
        generatingMusic.value = 'Error checking status.'
        clearInterval(intervalId)
      }
    }

    const submitForm = async (formData) => {
      if (!formData || !formData.lyrics) {
        console.warn('submitForm received empty data, ignoring.')
        return
      }

      const lyrics = formData.lyrics
      const tags = formData.tags
      const title = formData.title
      const duration = formData.duration == 0 ? 95 : Number(formData.duration)
      const steps = formData.steps == 0 ? 32 : Number(formData.steps)
      const cfg_strength = formData.cfg_strength == 0 ? 6.0 : Number(formData.cfg_strength)

      generatingMusic.value = `${percentComplete.value}% - Generating music...`

      try {
        const response = await fetch(`${configuration.api}/music/generate`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            title: title,
            lyrics: lyrics,
            duration: duration,
            steps: steps,
            cfg_strength: cfg_strength,
            chunked: true,
            tags: tags
          })
        })

        if (!response.ok) {
          throw new Error('Failed to generate music.')
        }

        const data = await response.json()
        taskId.value = data.id

        const intervalId = setInterval(() => {
          pollStatus(taskId.value, intervalId)
        }, 2000)
      } catch (error) {
        console.log(error)
        generatingMusic.value = ''
      }
    }

    const toggleListView = () => {
      listView.value = listView.value === 'library' ? 'trash' : 'library'
    }

    const toggleFavorite = () => {
      showFavorites.value = !showFavorites.value
    }

    watch([listView, showFavorites], fetchSongs)
    onMounted(fetchSongs)
    
    return { generatingMusic, taskId, soundFile, songs,
      loading,
      error,
      listView,
      showFavorites,
      toggleListView,
      toggleFavorite,
      submitForm
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
}

.column.right {
  flex: 0 0 auto;  
  overflow-y: auto;
  width: 100%;
}



</style>
