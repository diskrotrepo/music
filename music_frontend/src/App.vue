<template>
  <div class="container">
    <NavBar />
    <div class="main-content">
      <router-view />
    </div>
  </div>
</template>

<script>
import NavBar from './components/NavBar.vue';

export default {
  components: { NavBar }
};
</script>

<style>
.container {
  display: flex;
}

.main-content {
  margin-left: 220px;
  padding: 20px;
  flex: 1;
}
</style>
