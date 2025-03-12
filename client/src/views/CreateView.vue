<template>
    <Create @submit="submitForm" />
    <p v-if="generatingMusic" class="response">{{ generatingMusic }}</p>
    <audio v-if="musicId" controls>
        <source :src="`http://127.0.0.1:5000/static/music/${musicId}.wav`" type="audio/wav">
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
        const musicId = ref(null);

        const submitForm = async (formData) => {

            const lyrics = formData.lyrics;
            const tags = formData.tags;
            const title = formData.title;
            const steps = formData.steps == 0 ? 32 : Number(formData.steps);
            const cfg_strength = formData.cfg_strength == 0 ? 6.0 : Number(formData.cfg_strength);


            generatingMusic.value = 'Generating Music...'

            if (!formData || !formData.lyrics) {
                console.warn('submitForm received empty data, ignoring.');
                return;
            }

            try {
                const response = await fetch('http://127.0.0.1:5000/api/v1/music/generate', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        title: title,
                        lyrics: lyrics,
                        duration: 95,
                        steps: steps,
                        cfg_strength: cfg_strength,
                        chunked: true,
                        tags: tags,
                    })
                });

                if (!response.ok) throw new Error('Failed to generate music.');

                const data = await response.json();
                
                musicId.value = data.id;
                generatingMusic.value = ''
            } catch (error) {
                console.log(error);
            }
        };

        return { generatingMusic, musicId, submitForm };
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
