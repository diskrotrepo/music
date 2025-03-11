<template>
    <Create @submit="submitForm" />
    <p v-if="responseMessage" class="response">{{ responseMessage }}</p>
</template>

<script>
import { ref } from 'vue';
import Create from '../components/Create.vue';

export default {
    components: { Create },
    setup() {
        const responseMessage = ref('');

        const submitForm = async (formData) => {
            try {
                const response = await fetch('http://localhost:5000/api/v1/music/generate', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        lyrics: formData.lyrics,
                        duration: 95,
                        steps: 32,
                        cfg_strength: 6,
                        chunked: true,
                        tags: formData.tags,
                    })
                });

                if (!response.ok) throw new Error('Failed to generate music.');

                const data = await response.json();
                responseMessage.value = `Success! Music ID: ${data.id}`;
            } catch (error) {
                responseMessage.value = `Error: ${error.message}`;
            }
        };

        return { responseMessage, submitForm };
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
