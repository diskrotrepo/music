<template>
    <Create @submit="submitForm" />
    <audio v-if="musicId" controls>
        <source :src="`http://localhost:5000/static/music/${musicId}.wav`" type="audio/wav">
        Your browser does not support the audio element.
    </audio>
</template>

<script>
import { ref } from 'vue';
import Create from '../components/Create.vue';

export default {
    components: { Create },
    setup() {
        const responseMessage = ref('');
        const musicId = ref(null);

        const submitForm = async (formData) => {

            const lyrics = formData.lyrics;
            const tags = formData.tags;

            if (!formData || !formData.lyrics) {
                console.warn('submitForm received empty data, ignoring.');
                return;
            }

            try {
                const response = await fetch('http://localhost:5000/api/v1/music/generate', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        lyrics: lyrics,
                        duration: 95,
                        steps: 32,
                        cfg_strength: 6,
                        chunked: true,
                        tags: tags,
                    })
                });

                if (!response.ok) throw new Error('Failed to generate music.');

                const data = await response.json();
                responseMessage.value = `Success! Music ID: ${data.id}`;
                musicId.value = data.id;
            } catch (error) {
                responseMessage.value = `Error: ${error.message}`;
            }
        };

        return { responseMessage, musicId, submitForm };
    }
};
</script>

<style scoped>
.response {
    margin-top: 10px;
    font-weight: bold;
    color: green;
}
</style>
