<template>
    <div class="content">
        <a @click="showSongs" class="library-menu">Songs</a>
        <a @click="showFavorites" class="library-menu">Favorites</a>
        <a @click="showTrash" class="library-menu">Trash</a>
    </div>
</template>

<script>
export default {
  methods: {
    showSongs() {
      this.$emit('menu-select', 'songs')
    },
    showFavorites() {
      this.$emit('menu-select', 'favorites')
    },
    showTrash() {
      this.$emit('menu-select', 'trash')
    }
  }
}
</script>

<style scoped>

.content {
    color: white;
    font-weight: bold;
}

.library-menu {
    margin-right: 20px;
    color: white;
    text-decoration: none;
}

.library-menu a {
    color: white;
 
}

.library-menu:hover {
    text-decoration: underline 2px rgb(216, 29, 204);
    
   
}

</style>