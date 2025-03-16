<template>
  <Settings @submit="submitForm" />
</template>

<script>
import Settings from '../components/Settings.vue'

export default {
  components: { Settings },
  setup() {
    const updateModel = async (prompt, model, category) => {
      try {
        const response = await fetch('http://127.0.0.1:5000/api/v1/prompt', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            prompt: prompt,
            model: model,
            is_default: true,
            category: category
          })
        })

        if (!response.ok) throw new Error('Failed to save prompt.')
      } catch (error) {
        console.error('Error updating model:', error)
      }
    }

    const submitForm = async (formData) => {
      if (
        !formData ||
        !formData.lrc ||
        !formData.poet ||
        !formData.lrcModel ||
        !formData.poetModel
      ) {
        console.warn('submitForm received empty data, ignoring.')
        return
      }

      await updateModel(formData.lrc, formData.lrcModel, 'LRC')
      await updateModel(formData.poet, formData.poetModel, 'POET')
    }

    return { submitForm }
  }
}
</script>

<style scoped>
.response {
  margin-top: 10px;
  font-weight: bold;
  color: green;
}
</style>
