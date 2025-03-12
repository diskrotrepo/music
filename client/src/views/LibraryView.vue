<template>
    <div class="container mx-auto p-6">
      <h1 class="text-3xl font-bold mb-6">Music Library</h1>
      <p v-if="loading" class="text-gray-500">Loading...</p>
      <p v-if="error" class="text-red-500">Error: {{ error }}</p>
      <Library v-if="!loading && !error" :songs="songs" />
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from "vue";
  import Library from "@/components/Library.vue";
  
  export default {
    components: {
      Library,
    },
    setup() {
      const songs = ref([]);
      const loading = ref(true);
      const error = ref(null);
  
      const fetchSongs = async () => {
        try {
          const response = await fetch("http://127.0.0.1:5000/api/v1/library");
          if (!response.ok) {
            throw new Error("Failed to fetch songs");
          }
          const data = await response.json();
          songs.value = data.library || [];
        } catch (err) {
          error.value = err.message;
        } finally {
          loading.value = false;
        }
      };
  
      onMounted(fetchSongs);
  
      return {
        songs,
        loading,
        error,
      };
    },
  };
  </script>
  