<template>

  <Settings
    @submit="submitForm"
    @gpu-shared="enableSharing"
    @gpu-save="saveGpuSettings"
  />
</template>

<script>
import Settings from '../components/Settings.vue'
import configuration from '../../config/configuration.json'

export default {
  components: { Settings },

  setup() {

    const updateModel = async (prompt, model, category) => {
      try {
        const response = await fetch(`${configuration.api}/settings/prompt`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            prompt,
            is_default: true,
            category
          })
        })
        if (!response.ok) {
          throw new Error('Failed to save prompt.')
        }
      } catch (error) {
        console.error('Error updating model:', error)
      }
    }

 
    const submitForm = async (formData) => {

      if (!formData || !formData.lrc) {
       
        return
      }
      await updateModel(formData.lrc, formData.lrcModel, 'LRC')
    }

  
    const enableSharing = (sharingData) => {
      
      

      if (sharingData.nickname) {
        console.log('Disable sharing with data:', sharingData)

        fetch(`${configuration.api}/settings/register`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json'
          }
        }).then(() => {
          console.log('Sharing disabled.')
        });

        return;
      }

      console.log('Enabling sharing with data:', sharingData)

      fetch(`${configuration.api}/settings/register`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          nickname: sharingData.nickname
        })
      })

    }

    const saveGpuSettings = (gpuSettings) => {
     
      console.log('Saving GPU settings:', gpuSettings)

      fetch(`${configuration.api}/settings/inference_server`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          hostname: gpuSettings.hostname,
          port: gpuSettings.port,
          max_queue_size: gpuSettings.maxQueueSize
        })
      })
    }

    return {
      submitForm,
      enableSharing,
      saveGpuSettings
    }
  }
}
</script>

<style scoped>

</style>
