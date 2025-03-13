<template>
  <div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6">Music Library</h1>

    <!-- Buttons to toggle between Library/Trash & Favorites -->
    <div class="mb-4 flex space-x-4">
      <button 
        @click="toggleListView" 
        class="px-4 py-2 bg-blue-500 text-white rounded">
        {{ listView === "library" ? "View Trash" : "View Library" }}
      </button>

      <button 
        @click="toggleFavorite" 
        class="px-4 py-2 bg-green-500 text-white rounded">
        {{ showFavorites ? "Show All Songs" : "Show Favorites" }}
      </button>
    </div>

    <!-- Loading & Error Messages -->
    <p v-if="loading" class="text-gray-500">Loading...</p>
    <p v-if="error" class="text-red-500">{{ error }}</p>

    <!-- Music Library Component -->
    <Library v-if="!loading && !error" :songs="songs" />
  </div>
</template>

<script>
import { ref, onMounted, watch } from "vue";
import Library from "@/components/Library.vue";

export default {
  components: {
    Library,
  },
  setup() {
    const songs = ref([]);
    const loading = ref(true);
    const error = ref(null);
    const listView = ref("library"); // Default: show library
    const showFavorites = ref(false); // Default: show all songs

    const fetchSongs = async () => {
      loading.value = true;
      error.value = null;

      try {
        let url = `http://127.0.0.1:5000/api/v1/library?list_view=${listView.value}`;
        if (showFavorites.value) {
          url += "&favorite=true"; // Apply favorite filter if toggled on
        }

        const response = await fetch(url);
        if (!response.ok) {
          throw new Error("No songs found.");
        }
        const data = await response.json();
        songs.value = data.library || [];
      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    // Toggle between "library" and "trash"
    const toggleListView = () => {
      listView.value = listView.value === "library" ? "trash" : "library";
    };

    // Toggle between "favorites" and "all songs"
    const toggleFavorite = () => {
      showFavorites.value = !showFavorites.value;
    };

    // Fetch songs when listView or showFavorites changes
    watch([listView, showFavorites], fetchSongs);

    onMounted(fetchSongs);

    return {
      songs,
      loading,
      error,
      listView,
      showFavorites,
      toggleListView,
      toggleFavorite,
    };
  },
};
</script>
