<template>
    <div class="content">
        <h1>Create</h1>
        <form @submit.prevent="handleSubmit">
            <textarea v-model="lyrics" rows="10" cols="40" placeholder="Enter lyrics..."></textarea>

            <input v-model="tags" type="text" placeholder="tags" size="50" />

            <p>
                <input type="submit" value="Create" />
            </p>
        </form>
    </div>
</template>

<script>
import { ref } from 'vue';

export default {
    setup(_, { emit }) {
        const lyrics = ref('');
        const tags = ref('');

        const handleSubmit = () => {
            event.preventDefault();
            emit('submit', { lyrics: lyrics.value, tags: tags.value });
        };

        return { lyrics, tags, handleSubmit };
    }
};
</script>

<style scoped>
.content {
    margin-left: 220px;
    padding: 20px;
}
</style>
