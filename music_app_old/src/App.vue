<template>
  <div class="container">
    <NavBar />
    <div class="main-content">
      <router-view />
    </div>
    <div class="player">
      <Player />
    </div>
  </div>
</template>

<script>
import NavBar from './components/NavBar.vue'
import Player from './components/Player.vue';

export default {
  components: { NavBar, Player }
}
</script>

<style>
.container {
  display: flex;
}

.main-content {
  margin-left: 100px;
  flex: 1;
}

.player {
  position: fixed;
  bottom: 0;
  left: 0;
  border-top: rgb(255, 255, 255) 0.05em solid;
  background-color: rgb(25, 25, 29);
  height: 50px;
  width: 100%;
  z-index: 10; /* Optional: ensures it stays above other content */
}
</style>
