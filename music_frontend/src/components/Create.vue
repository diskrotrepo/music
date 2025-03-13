<template>
    <div class="content">
        <h1>Create</h1>
        <form @submit.prevent="handleSubmit">
            <input v-model="title" type="text" placeholder="your song title" size="50" />
            <input v-model="tags" type="text" placeholder="tags" size="50" />
            <textarea v-model="lyrics" rows="10" cols="40" placeholder="Enter lyrics..."></textarea>
            <p>
                <b>Steps</b>
                <input v-model="steps" type="number" placeholder="steps" size="5" />
            </p>
            <p>
                <b>cfg strength</b>
                <input v-model="cfg_strength" type="number" placeholder="cfg strength" size="5" step="0.1" />
            </p>
            <p>
                <button type="button" @click="generateLyrics">Generate Lyrics</button>
            </p>
            <p>
                <input type="submit" value="Create" />
            </p>
        </form>
    </div>
</template>

<script>
import { ref } from "vue";

export default {
    setup(_, { emit }) {
        const lyrics = ref("");
        const tags = ref("");
        const title = ref("");
        const steps = ref(32);
        const cfg_strength = ref(6.0);

        const handleSubmit = () => {
            emit("submit", {
                lyrics: lyrics.value,
                tags: tags.value,
                title: title.value,
                steps: steps.value,
                cfg_strength: cfg_strength.value,
            });
        };

        const generateLyrics = async () => {
            try {
                const response = await fetch("http://127.0.0.1:5000/api/v1/lyrics/poet", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ lyrics: lyrics.value }),
                });

                if (!response.ok) {
                    throw new Error("Failed to generate lyrics");
                }

                const data = await response.json();
                lyrics.value = data.lyrics; // Correctly update the lyrics ref
            } catch (error) {
                console.error("Error generating lyrics:", error);
            }
        };

        return { lyrics, tags, title, steps, cfg_strength, handleSubmit, generateLyrics };
    },
};
</script>

<style scoped>
.content {
    margin-left: 220px;
    padding: 20px;
}
</style>
