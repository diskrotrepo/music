<template>
  <div class="settings-container">
    <h1>Settings</h1>

    <ul class="tabs" >
      
      <li 
        :class="{ active: activeTab === 'network' }" 
        @click="activeTab = 'network'">
        Network
      </li>
      <li 
        :class="{ active: activeTab === 'gpu' }" 
        @click="activeTab = 'gpu'">
        GPU
      </li>
      <li 
        :class="{ active: activeTab === 'prompts' }" 
        @click="activeTab = 'prompts'">
        Prompts
      </li>
    </ul>

    <div v-if="activeTab === 'prompts'" class="tab-content">
      <form @submit.prevent="handlePromptsSubmit">
        <h3>LRC Prompt</h3>
        <p>
          This prompt is used to generate an 
          <a 
            href="https://en.wikipedia.org/wiki/LRC_(file_format)" 
            target="_top">
              LRC file
          </a> 
          which determines where your words are placed within a song in time.
        </p>

        <textarea 
          v-model="lrc" 
          placeholder="LRC Prompt">
        </textarea>

        <div class="save-button">
          <button class="submitButton pulse" type="submit">
            Save
          </button>
        </div>
      </form>
    </div>

    <!-- Network Tab -->
    <div v-if="activeTab === 'network'" class="tab-content">
      <h2>Sharing</h2>
      <p>In order to share your GPU you need to enable sharing. Your nickname will be seen by anyone that connects to you.</p>
      <label>
            Nickname:
            </label>
            <input 
              v-model="sharing.nickname" 
              type="text"
              placeholder="nickname"/>
          
      <button @click="handleEnableSharing" class="submitButton pulse">{{ sharing.nickname ? 'Disable' : 'Enable' }}</button>
    </div>

    <!-- GPU Tab -->
    <div v-if="activeTab === 'gpu'" class="tab-content">
      <h2>Inference Service</h2>
      <form @submit.prevent="handleGpuSubmit">

          <label>
            Hostname:
            <input 
              v-model="gpuSettings.hostname" 
              type="text"
              value="localhost"
              placeholder="Hostname"/>
          </label>
          <label>
            Port:
            <input 
              v-model="gpuSettings.port" 
              type="number"
              value="5001"
              placeholder="5001"/>
          </label>
          <p>
            <label>
              Max Queue Size:
              <input 
                v-model="gpuSettings.maxQueueSize" 
                type="number"
                value="10"
                placeholder="Max Queue Size"/>
            </label>
          </p>
         
        <button class="submitButton pulse right-button" type="submit">
          Save
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import configuration from '../../config/configuration.json'

export default {
  setup(_, { emit }) {

    const activeTab = ref('network')

    const lrc = ref('')
    const lrcModel = ref('')  

    const gpuSettings = ref({
      hostname: 'localhost',
      port: 5001,
      maxQueueSize: 10,
    })

    const sharing = ref({
      nickname: '',
    })


    const fetchPrompts = async () => {
      try {
        const response = await fetch(`${configuration.api}/settings/prompt/LRC`)
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`)
        }
        const data = await response.json()
        lrc.value = data?.prompt || ''
        lrcModel.value = data?.model || ''
      } catch (e) {
        console.error('Error fetching LRC:', e)
        lrc.value = ''
        lrcModel.value = ''
      }
    }

     const fetchGpu = async () => {
      try {
        const response = await fetch(`${configuration.api}/settings/inference_server`)
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`)
        }
        const data = await response.json()

        gpuSettings.value.hostname = data.hostname;
        gpuSettings.value.port = data.port;
        gpuSettings.value.maxQueueSize = data.maxQueueSize;

        
      } catch (e) {
        console.error('Error fetching inference_server:', e)
      }
     }

     const fetchClient = async () => {
      try {
        const response = await fetch(`${configuration.api}/settings/client`)
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`)
        }
        const data = await response.json()

        if (data !== undefined) {
          sharing.value.nickname = data.nickname
        }
      } catch (e) {
        console.error('Error fetching clien:', e)
      }
    }

    onMounted(() => {
      fetchPrompts()
      fetchGpu()
      fetchClient()
    });

    const handlePromptsSubmit = () => {
     
      emit('submit', {
        lrc: lrc.value,
      })
    }

    const handleEnableSharing = () => {
      emit('gpu-shared', sharing.value)
    }

    const handleGpuSubmit = () => {
      emit('gpu-save', gpuSettings.value)
    }

    return {
      activeTab,
      lrc,
      lrcModel,
      gpuSettings,
      sharing,
      handlePromptsSubmit,
      handleEnableSharing,
      handleGpuSubmit,
    }
  }
}
</script>

<style scoped>



.settings-container {
  margin-left: 20px;
  padding: 10px;
}


a {
  color: white;
  text-decoration: underline;
  font-weight: bolder;
}

.save-button {
  position: relative;
  left: 330px;
  margin-top: 40px;
}

.gpu-form {
  margin: 0.5em 0;
}
</style>
