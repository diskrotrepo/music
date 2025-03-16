<template>
  <nav class="sidebar">
    <span class="logo">diskrot</span>
    <ul>
      <li>
        <router-link to="/"><i class="fa-solid fa-house"></i> Home</router-link>
      </li>
      <li>
        <router-link to="/create"><i class="fa-solid fa-music"></i> Create</router-link>
      </li>
      <li>
        <router-link to="/library"><i class="fa-solid fa-record-vinyl"></i> Library</router-link>
      </li>
      <li>
        <router-link to="/settings"><i class="fa-solid fa-sliders"></i> Settings</router-link>
      </li>
    </ul>
    <ul class="bottomNav">
      <li class="socialLinks">
        <a href="https://github.com/diskrotrepo/music" target="_new"
          ><i class="fa-brands fa-github socialLinks"></i> source</a
        >
      </li>
      <li class="socialLinks">
        <a href="https://txt.diskrot.com" target="_new"
          ><i class="fa-brands fa-mastodon socialLinks"></i> community</a
        >
      </li>
      <li class="socialLinks">
        <a href="http://localhost:3000/api/v1/docs" target="_new"
          ><i class="fa-solid fa-book socialLinks"></i> API</a
        >
      </li>
    </ul>
  </nav>
</template>

<style scoped>
.sidebar {
  width: 110px;
  background: #333;
  color: white;
  height: 100vh;
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  flex-direction: column;
  padding: 20px;
  border-right: #1a1a1a 1px solid;
}

ul {
  list-style: none;
  padding: 0;
}

li {
  margin-bottom: 10px;
}

nav a {
  display: block;
  width: 200%;
  box-sizing: border-box;
  padding: 5px;
  color: #fff;
  text-decoration: none;
  font-size: 18px;
}

a:hover {
  text-decoration: none;
  background-color: rgb(237, 34, 146);
  width: 120%;
}

.bottomNav {
  position: absolute;
  bottom: 0;
  left: 0;
  margin-bottom: 100px;
  margin-left: 10px;
}

.socialLinks {
  font-size: 0.7em;
}

.logo {
  font-size: 1.5em;
  font-weight: bold;
  margin-bottom: 20px;
  color: white;
  background-color: rgb(221, 1, 1);
  padding: 10px;
  width: 100%;
}
</style>
