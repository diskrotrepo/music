import { defineStore } from 'pinia'

export const useClientStore = defineStore('client', {
    state: () => ({
        client: null,
    }),
    actions: {
        setClient(client) {
            this.client = client
        },
    },
})