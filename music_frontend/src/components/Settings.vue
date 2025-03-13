<template>
    <div class="content">
        <h1>Settings</h1>
        <form @submit.prevent="handleSubmit">

            <textarea v-model="lrc" rows="15" cols="45" placeholder="LRC Prompt"></textarea>
            <input v-model="lrcModel" type="text" placeholder="lrc model" size="50" />
            <textarea v-model="poet" rows="15" cols="45" placeholder="Lyric Generator"></textarea>
            <input v-model="poetModel" type="text" placeholder="poet model" size="50" />
            <p>
                <input type="submit" value="Save" />
            </p>
        </form>
    </div>
</template>

<script>
import { ref, onMounted } from "vue";

export default {
    setup(_, { emit }) {
        const lrc = ref('');
        const poet = ref('');
        const lrcModel = ref('');
        const poetModel = ref('');

        const fetchPrompt = async () => {
            try {
                const response = await fetch("http://127.0.0.1:5000/api/v1/prompt/LRC");

                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                const lrcData = await response.json();
                if (lrcData && typeof lrcData === 'object') {
                    lrc.value = lrcData.prompt || '';
                    lrcModel.value = lrcData.model || '';
                } else {
                    lrc.value = '';
                    lrcModel.value = '';
                }
            } catch (e) {
                console.error("Error fetching LRC:", e);
                lrc.value = '';
                lrcModel.value = '';
            }

            try {
                const response = await fetch("http://127.0.0.1:5000/api/v1/prompt/POET");

                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                const poetData = await response.json();
                if (poetData && typeof poetData === 'object') {
                    poet.value = poetData.prompt || '';
                    poetModel.value = poetData.model || '';
                } else {
                    poet.value = '';
                    poetModel.value = '';
                }
            } catch (e) {
                console.error("Error fetching POET:", e);
                poet.value = '';
                poetModel.value = '';
            }
        };

        onMounted(fetchPrompt); 
        
        const handleSubmit = (event) => {
            event.preventDefault();
            emit('submit', {
                lrc: lrc.value,
                lrcModel: lrcModel.value,
                poet: poet.value,
                poetModel: poetModel.value
            });
        };

        return { lrc, lrcModel, poet, poetModel, handleSubmit };
    }
};
</script>



<style scoped>
.content {
    margin-left: 220px;
    padding: 20px;
}
</style>
