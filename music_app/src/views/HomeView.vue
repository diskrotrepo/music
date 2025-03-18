<template>
  <div class="content">
    <h1>diskrot</h1>
    <div class="content">
      <p>
        Welcome to a <span class="logo">diskrot</span> experiment. This is a proof of concept application will allow you
        to generate music, but it has known issues, so please be patient with us. A future version of this application
        will allow you to connect to a distributed network of GPUs to generate music with your friends. For
        now, there's a single server that will process the requests.
      </p>
      <p>
        You should have been provided with a code. Go to the settings page and enter the code to get started. When you
        click generate your request will be sent to a server managed by diskrot. The server will process your request in
        the order it was received. Once your requst is processed you'll be able to play and download your music.
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