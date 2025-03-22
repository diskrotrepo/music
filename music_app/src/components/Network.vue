<template>
  <div class="settings-container">
    <h1>Network</h1>
    
    <ul class="tabs">
      <li
        :class="{ active: activeTab === 'invitations' }"
        @click="activeTab = 'invitations'">
        Invitations
      </li>
      <li
        :class="{ active: activeTab === 'queue' }"
        @click="activeTab = 'queue'">
        Queue
      </li>
    </ul>

  
    <div v-if="activeTab === 'invitations'" class="tab-content">
      <div class="text">
        You should only share your invitation code with people you trust.
      </div>
      <button @click="$emit('create-invitation')" class="submitButton pulse right-button">
        Create Invite
      </button>
      <p v-if="invitationCode">
        Your invitation code is: <strong>{{ invitationCode }}</strong>
      </p>

      <table>
        <thead>
          <tr>
            <th>Nickname</th>
            <th>Status</th>
            <th>Accepted Date</th>
            <th>Delete</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(item, index) in invitationItems"
            :key="index"
            :class="index % 2 === 0 ? 'even-row' : 'odd-row'"
          >
            <td>{{ item.nickname }}</td>
            <td>{{ item.status }}</td>
            <td>{{ item.acceptedDate || '-' }}</td>
            <td>
              <button @click="$emit('delete-invitation', index)">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div v-if="activeTab === 'queue'" class="tab-content">
      <div class="text">
        These are current items set to be processed by the inference server.
      </div>
      <button @click="$emit('clear-queue')" class="submitButton pulse right-button">
        Clear Queue
      </button>
      <table>
        <thead>
          <tr>
            <th>Title</th>
            <th>Status</th>
            <th>Nickname</th>
            <th>Submitted</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(item, index) in queueItems"
            :key="index"
            :class="index % 2 === 0 ? 'even-row' : 'odd-row'"
          >
            <td>{{ item.title }}</td>
            <td>{{ item.status }}</td>
            <td>{{ item.nickname }}</td>
            <td>{{ item.submitted }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  name: 'Network',

  props: {
    invitationCode: {
      type: String,
      default: ''
    },
    queueItems: {
      type: Array,
      default: () => []
    },
    invitationItems: {
      type: Array,
      default: () => []
    }
  },

  setup() {
   
    const activeTab = ref('invitations')

    return {
      activeTab
    }
  }
}
</script>

<style scoped>
.settings-container {
  margin-left: 20px;
  padding: 10px;
}

table {
  border-collapse: collapse;
  margin-top: 16px;
  width: 100%;
}

thead tr {
  background-color: #999;
  color: #fff;
}

th,
td {
  padding: 8px;
  border: 1px solid #ccc;
}

.even-row {
  background-color: #f9f9f9;
}

.odd-row {
  background-color: #eaeaea;
}

.right-button {
  margin-left: 682px;
}

.text {
  color: #fff;
}
</style>
