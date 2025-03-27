<template>
  <div class="content">
    <h1>diskrot</h1>
    <div class="content">
      <p>
        Welcome to a <span class="logo">diskrot</span> experiment. This is a proof of concept application will allow you to generate music, but it has known issues, so please be patient with us. This application will allow you to both generate music locally, and shared your GPU with your friends so that they can generate music as well. 
      </p>
      <p>
        Please note, during this experimental stage, it's entirely possible that bugs may exist that cause you to lose work.
      </p>
      <p class="signature">
        -- diskrot team
      </p>
    </div>

  </div>
</template>

<style scoped>
h1 {
  color: white;
  padding-left: 20px;
}

.content {
  padding-left: 20px;
  color: rgb(255, 255, 255);
  width: 100%;
}

.signature {
  font-style: italic;
  text-align: right;
}

.logo {
  background-color: red;
  color: white;
  font-weight: bolder;
  padding: 0.2em;
}
</style>