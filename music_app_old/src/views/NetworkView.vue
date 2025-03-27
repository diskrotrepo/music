<template>
  <Network
    :invitationCode="invitationCode"
    :queueItems="queueItems"
    :invitationItems="invitationItems"
    :connectionItems="connectionItems"
    @accept-invitation="handleAcceptInvitation"
    @create-invitation="handleCreateInvitation"
    @clear-queue="handleClearQueue"
    @delete-invitation="handleDeleteInvitation"
    @delete-connection="handleDeleteConnection"
  />
</template>

<script>
import { ref, onMounted } from 'vue'
import Network from '../components/Network.vue'
import configuration from "../../config/configuration.json";

export default {
  name: 'NetworkParent',
  components: { Network },
  setup() {
   
    const invitationCode = ref('')
    const invitationItems = ref([])
    const connectionItems = ref([])
    const queueItems = ref([])

  
    onMounted(async () => {
      await fetchInvitations()
      await fetchQueue()
      await fetchConnections()
    })

    const fetchConnections = async () => {
      try {
        const response = await fetch(`${configuration.api}/connections`, {
          method: 'GET',
          headers: { 'Content-Type': 'application/json' }
        })
        if (!response.ok) {
          throw new Error(`Error fetching connections: ${response.statusText}`)
        }
        const data = await response.json()
       
        connectionItems.value = data
      } catch (error) {
        console.error('Error fetching connections:', error)
      }
    }
 
    const fetchInvitations = async () => {
      try {
        const response = await fetch(`${configuration.api}/invitations`, {
          method: 'GET',
          headers: { 'Content-Type': 'application/json' }
        })
        if (!response.ok) {
          throw new Error(`Error fetching invitations: ${response.statusText}`)
        }
        const data = await response.json()
       
        invitationItems.value = data
      } catch (error) {
        console.error('Error fetching invitations:', error)
      }
    }
    const fetchQueue = async () => {
      try {
        const response = await fetch(`${configuration.api}/queue`, {
          method: 'GET',
          headers: { 'Content-Type': 'application/json' }
        })
        if (!response.ok) {
          throw new Error(`Error fetching queue items: ${response.statusText}`)
        }
        const data = await response.json()

        
       
        queueItems.value = data
      } catch (error) {
        console.error('Error fetching queue:', error)
      }
    }

  
    const handleAcceptInvitation = async (code) => {
      try {
      
        const response = await fetch(`${configuration.api}/invitations/accept/${code}`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' }
        })
        if (!response.ok) {
          throw new Error(`Error accepting invitation: ${response.statusText}`)
        }
        const newInvitation = await response.json()
       
        invitationItems.value.push(newInvitation)

       
        invitationCode.value = code

        fetchConnections();

      } catch (error) {
        console.error('Error accepting invitation:', error)
      }
    }

  
    const handleCreateInvitation = async () => {
      try {
        const response = await fetch(`${configuration.api}/invitations`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' }
        })
        if (!response.ok) {
          throw new Error(`Error creating invitation: ${response.statusText}`)
        }
       
        const data = await response.json()

        invitationCode.value = data.code || '' 

        fetchInvitations();
       

      } catch (error) {
        console.error('Error creating invitation:', error)
      }
    }

 
    const handleClearQueue = async () => {
      try {
        const response = await fetch(`${configuration.api}/queue`, {
          method: 'DELETE'
        })
        if (!response.ok) {
          throw new Error(`Error clearing queue: ${response.statusText}`)
        }
       
        queueItems.value = []

      } catch (error) {
        console.error('Error clearing queue:', error)
      }
    }

   
    const handleDeleteInvitation = async (index) => {
      try {
      
        const itemToDelete = invitationItems.value[index]
        
       
        const response = await fetch(`${configuration.api}/invitations/${itemToDelete.id}`, {
          method: 'DELETE'
        })
        if (!response.ok) {
          throw new Error(`Error deleting invitation: ${response.statusText}`)
        }
        
        invitationItems.value.splice(index, 1)
      } catch (error) {
        console.error('Error deleting invitation:', error)
      }
    }

    const handleDeleteConnection = async (index) => {
      try {
      
        const connectionToDelete = connectionItems.value[index]

        console.log(connectionToDelete);
        
       
        const response = await fetch(`${configuration.api}/connections/${connectionToDelete.client_id}`, {
          method: 'DELETE'
        })
        if (!response.ok) {
          throw new Error(`Error deleting connection: ${response.statusText}`)
        }
        
        connectionItems.value.splice(index, 1)
      } catch (error) {
        console.error('Error deleting connection:', error)
      }
    }

    return {
      invitationCode,
      invitationItems,
      connectionItems,
      queueItems,
      handleAcceptInvitation,
      handleCreateInvitation,
      handleClearQueue,
      handleDeleteInvitation,
      handleDeleteConnection
    }
  }
}
</script>

<style scoped>
body {
  color: white;
}
</style>
