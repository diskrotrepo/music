<template>
  <div class="content">
    <h1>Settings</h1>
    <form @submit.prevent="handleSubmit">
      <textarea v-model="lrc" rows="15" cols="45" placeholder="LRC Prompt"></textarea>
      <textarea v-model="poet" rows="15" cols="45" placeholder="Lyric Generator"></textarea>

      <div class="save-button">
        <button class="submitButton pulse" type="submit">
          Save
        </button>
      </div>
    </form>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import configuration from '../../config/configuration.json'

export default {
  setup(_, { emit }) {
    const lrc = ref('')
    const poet = ref('')
    const lrcModel = ref('')
    const poetModel = ref('')

    const fetchPrompt = async () => {
      try {
        const response = await fetch(`${configuration.api}/prompt/LRC`)

        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`)
        }

        const lrcData = await response.json()
        if (lrcData && typeof lrcData === 'object') {
          lrc.value = lrcData.prompt || ''
          lrcModel.value = lrcData.model || ''
        } else {
          lrc.value = ''
          lrcModel.value = ''
        }
      } catch (e) {
        console.error('Error fetching LRC:', e)
        lrc.value = ''
        lrcModel.value = ''
      }

      try {
        const response = await fetch(`${configuration.api}/prompt/POET`)

        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`)
        }

        const poetData = await response.json()
        if (poetData && typeof poetData === 'object') {
          poet.value = poetData.prompt || ''
          poetModel.value = poetData.model || ''
        } else {
          poet.value = ''
          poetModel.value = ''
        }
      } catch (e) {
        console.error('Error fetching POET:', e)
        poet.value = ''
        poetModel.value = ''
      }
    }

    onMounted(fetchPrompt)

    const handleSubmit = (event) => {
      event.preventDefault()
      emit('submit', {
        lrc: lrc.value,
        lrcModel: lrcModel.value,
        poet: poet.value,
        poetModel: poetModel.value
      })
    }

    return { lrc, lrcModel, poet, poetModel, handleSubmit }
  }
}
</script>

<style scoped>
.content {
  margin-left: 20px;
  padding: 10px;
}

h1 {
  color: white;
}

.save-button {
  position: relative;
  left: 330px;
  margin-top: 40px;
}

input {
  background-color: rgb(29, 29, 29);
  border: none;
  border-bottom: rgb(203, 203, 203) solid 0.1em;
  color: rgb(250, 91, 250);
  font-family: Arial, Helvetica, sans-serif;
  margin: 0.5em 0.5em;
  outline: none;
}

textarea {
  margin: 0.5em 0.5em;
  background-color: rgb(27, 27, 27);
  border: none;
  color: rgb(250, 91, 250);
  width: 400px;
  height: 200px;
  font-size: 1em;
  font-family: Arial, Helvetica, sans-serif;
  resize: none;
}

.submitButton {
  background-color: rgb(29, 29, 29);
  border-radius: 0.6em;
  border: rgb(250, 91, 250) solid 0.1em;
  padding: 0.5em 0.5em;
  font-size: 1.2em;
  color: rgb(255, 255, 255);
  transition: 0.25s;

  &:hover,
  &:focus {
    border-color: rgb(236, 54, 130);
    color: rgb(250, 91, 250);
  }
  
}

.pulse:hover,
.pulse:focus {
  animation: pulse 1s;
  box-shadow: 0 0 0 1em transparent;
}

@keyframes pulse {
  0% {
    box-shadow: 0 0 0 0 rgb(250, 91, 250);
  }
}

</style>
