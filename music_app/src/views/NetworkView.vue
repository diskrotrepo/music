<template>
  
  <Network
    :invitationCode="invitationCode"
    :queueItems="queueItems"
    :invitationItems="invitationItems"
    @create-invitation="handleCreateInvitation"
    @clear-queue="handleClearQueue"
    @delete-invitation="handleDeleteInvitation"
  />
</template>

<script>
import { ref } from 'vue'
import Network from '../components/Network.vue'
import configuration from '../../config/configuration.json'

export default {
  name: 'NetworkParent',
  components: { Network },
  setup() {
    
    const invitationCode = ref('')
    const invitationItems = ref([
      { nickname: 'Friend1', status: 'Unused', acceptedDate: null },
      { nickname: 'Friend2', status: 'Accepted', acceptedDate: '2025-01-20' }
    ])

    const queueItems = ref([
      { title: 'Song A', status: 'Pending', nickname: 'User123', submitted: '2025-01-15' },
      { title: 'Song B', status: 'Processing', nickname: 'DJMike', submitted: '2025-01-16' },
      { title: 'Song C', status: 'Completed', nickname: 'JaneDoe', submitted: '2025-01-17' }
    ])

   
    const handleCreateInvitation = async () => {
      try {
      
        invitationCode.value = 'ABC123'
      } catch (error) {
        console.error('Error creating invitation:', error)
      }
    }

    const handleClearQueue = async () => {
      try {
       
        queueItems.value = []
      } catch (error) {
        console.error('Error clearing queue:', error)
      }
    }

    const handleDeleteInvitation = (index) => {
    
      invitationItems.value.splice(index, 1)
    }

    return {
      invitationCode,
      invitationItems,
      queueItems,
      handleCreateInvitation,
      handleClearQueue,
      handleDeleteInvitation
    }
  }
}
</script>

<style scoped>
body {
  color: white;
}
</style>
