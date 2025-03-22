<template>
  <div class="content">
    <div class="create">
      <h1>Create</h1>
      <form @submit.prevent="handleSubmit">
        <input
          v-model="title"
          class="song-title"
          type="text"
          placeholder="your song title"
          size="40"
        />
        <input
          v-model="tags"
          class="song-tags"
          type="text"
          placeholder="describe your sound"
          size="40"
        />
        <textarea v-model="lyrics" rows="10" cols="40" placeholder="lyrics..."></textarea>
        <div class="not-advanced">
          <span class="options" @click="toggleAdvanced">Advanced </span>
          <label class="switch">
            <input type="checkbox" v-model="showAdvanced">
            <span class="slider round"></span>
          </label>
        </div>
        <div :class="['advanced', showAdvanced ? 'show-advanced' : '']">
         
          <b>Duration</b><input class="advanced-input" v-model="duration" type="number" placeholder="duration" size="5" />         
          <b>Steps</b>
          <input v-model="steps" class="advanced-input" type="number" placeholder="steps" size="5" />
       
          <b>cfg strength</b>
          <input
          class="advanced-input"
            v-model="cfg_strength"
            type="number"
            placeholder="cfg strength"
            size="5"
            step="0.1"
          />
        </div>
        

        <div class="create-button">
          <button class="submitButton pulse" type="submit">
            Generate
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import configuration from '../../config/configuration.json'


export default {
  setup(_, { emit }) {
    const lyrics = ref('')
    const tags = ref('')
    const title = ref('')
    const steps = ref(32)
    const duration = ref(95)
    const cfg_strength = ref(6.0)
    const showAdvanced = ref(false)

    const toggleAdvanced = () => {
      showAdvanced.value = !showAdvanced.value
    }

    const handleSubmit = () => {
      emit('submit', {
        lyrics: lyrics.value,
        tags: tags.value,
        title: title.value,
        steps: steps.value,
        duration: duration.value,
        cfg_strength: cfg_strength.value
      })
    }

    const generateLyrics = async () => {
      try {
        const response = await fetch(`${configuration.api}/lyrics/poet`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ lyrics: lyrics.value })
        })

        if (!response.ok) {
          throw new Error('Failed to generate lyrics')
        }

        const data = await response.json()
        lyrics.value = data.lyrics
      } catch (error) {
        console.error('Error generating lyrics:', error)
      }
    }

    return {
      lyrics,
      tags,
      title,
      steps,
      cfg_strength,
      duration,
      showAdvanced,
      toggleAdvanced,
      handleSubmit,
      generateLyrics
    }
  }
}
</script>

<style scoped>

h1 {
  font-size: 1.3em;
  padding-left: 5px;
}

.content {
  padding-left: 20px;
  color: rgb(255, 255, 255);
}

.not-advanced {
  position: absolute;
  left: 480px;  
}

.advanced-option-title {
  align-items: center;
  justify-content: center;

}

.advanced-input {
  margin-top: 50px;
  width: 50px;
}

.advanced {
  display: none;
  padding: 0.6em;
  text-align: right; 
}

.show-advanced {
  display: block;
}

.options {
  color: rgb(255, 255, 255);
  cursor: pointer;
  font-weight: bolder;
}

.create-button {
  position: relative;
  left: 360px;
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
  width: 480px;
}

textarea {
  margin: 0.5em 0.5em;
  background-color: rgb(27, 27, 27);
  border: none;
  color: rgb(250, 91, 250);
  width: 480px;
  height: 200px;
  font-size: 1em;
  font-family: Arial, Helvetica, sans-serif;
  resize: none;
}

.song-title {
  font-size: 1.1em;
  font-weight: bold;
}

.song-tags {
  font-size: 1.1em;
  font-weight: bold;
}

:focus {
  outline: none;
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

.switch {
  position: relative;
  display: inline-block;
  width: 50px;
  height: 24px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 20px;
  width: 20px;
  left: 4px;
  bottom: 2px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: rgb(250, 91, 250);
}

input:focus + .slider {
  box-shadow: 0 0 1px rgb(250, 91, 250);
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 30px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>
