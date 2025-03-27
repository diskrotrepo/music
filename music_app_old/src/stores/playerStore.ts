import { defineStore } from 'pinia'

export const usePlayerStore = defineStore('player', {
    state: () => ({
        currentSong: null,
    }),
    actions: {
        setCurrentSong(song) {
            this.currentSong = song
        },
    },
})