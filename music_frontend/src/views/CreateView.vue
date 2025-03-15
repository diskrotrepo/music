<template>
    <Create @submit="submitForm" />
    <p v-if="generatingMusic" class="response">{{ generatingMusic }}</p>

    <audio v-if="taskId && !generatingMusic" controls>
        <source :src="`${soundFile}`" type="audio/wav" />
        Your browser does not support the audio element.
    </audio>
</template>

<script>
import { ref } from 'vue';
import Create from '../components/Create.vue';

export default {
    components: { Create },
    setup() {
        const generatingMusic = ref('');
        const taskId = ref(null);
        const soundFile = ref(null);
        const percentComplete = ref(0);

        const pollStatus = async (id, intervalId) => {
            try {
                const response = await fetch(`http://127.0.0.1:5000/api/v1/status/${id}`);
                if (!response.ok) throw new Error('Failed to check status.');

                const data = await response.json();
                if (data.processing_status === "COMPLETE") {
                    generatingMusic.value = "";
                    soundFile.value = `http://${data.filename}`;
                    clearInterval(intervalId);
                } else {
                    percentComplete.value = percentComplete.value + 5;
                    generatingMusic.value = `${percentComplete.value}% - Generating music...`;
                }
            } catch (e) {
                console.error(e);
                generatingMusic.value = "Error checking status.";
                clearInterval(intervalId);
            }
        };

        const submitForm = async (formData) => {
            if (!formData || !formData.lyrics) {
                console.warn('submitForm received empty data, ignoring.');
                return;
            }

            const lyrics = formData.lyrics;
            const tags = formData.tags;
            const title = formData.title;
            const duration = formData.duration == 0 ? 95 : Number(formData.duration);
            const steps = formData.steps == 0 ? 32 : Number(formData.steps);
            const cfg_strength = formData.cfg_strength == 0 ? 6.0 : Number(formData.cfg_strength);

            generatingMusic.value = `${percentComplete.value}% - Generating music...`;

            try {
                const response = await fetch('http://127.0.0.1:5000/api/v1/music/generate', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        title: title,
                        lyrics: lyrics,
                        duration: duration,
                        steps: steps,
                        cfg_strength: cfg_strength,
                        chunked: true,
                        tags: tags
                    })
                });

                if (!response.ok) {
                    throw new Error('Failed to generate music.');
                }

                const data = await response.json();
                taskId.value = data.id;

                const intervalId = setInterval(() => {
                    pollStatus(taskId.value, intervalId);
                }, 2000);

            } catch (error) {
                console.log(error);
                generatingMusic.value = '';
            }
        };

        return { generatingMusic, taskId, soundFile, submitForm };
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
