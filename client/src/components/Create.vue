<template>
    <div class="content">
        <h1>Create</h1>
        <form @submit.prevent="handleSubmit">
            <input v-model="title" type="text" placeholder="your song title" size="50" />
            <input v-model="tags" type="text" placeholder="tags" size="50" />
            <textarea v-model="lyrics" rows="10" cols="40" placeholder="Enter lyrics..."></textarea>
            <p>
                <b>Steps</b><input v-model="steps" type="text" placeholder="steps" size="5" value=32/>
            </p>
            <p>
                <b>cfg strength</b><input v-model="cfg_strength" type="text" placeholder="cfg strength" size="5" value=6.0/>
            </p>
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
        const title = ref('');
        const steps = ref(32);
        const cfg_strength = ref(6.0);


        const handleSubmit = () => {
            event.preventDefault();
            emit('submit', { lyrics: lyrics.value, tags: tags.value, title: title.value, steps: steps.value, cfg_strength: cfg_strength.value });
        };

        return { lyrics, tags, title,steps,cfg_strength, handleSubmit };
    }
};
</script>

<style scoped>
.content {
    margin-left: 220px;
    padding: 20px;
}
</style>
