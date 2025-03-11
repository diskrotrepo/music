<template>
    <nav class="sidebar">
        <ul>
            <li><router-link to="/">Home</router-link></li>
            <li><router-link to="/create">Create</router-link></li>
            <li><router-link to="/settings">Settings</router-link></li>
        </ul>
    </nav>
</template>

<style scoped>
.sidebar {
    width: 200px;
    background: #333;
    color: white;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: column;
    padding: 20px;
}

ul {
    list-style: none;
    padding: 0;
}

li {
    margin-bottom: 10px;
}

a {
    color: white;
    text-decoration: none;
    font-size: 18px;
}

a:hover {
    text-decoration: underline;
}
</style>
