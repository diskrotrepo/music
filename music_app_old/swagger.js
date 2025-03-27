import swaggerAutogen from 'swagger-autogen';

const doc = {
    info: {
        title: 'diskrot: Create',
        description: 'The API for this application'
    },

    host: 'localhost:3000',
    definitions: {
        Song: {
            "title": "Banger #1",
            "lyrics": "I am a song. (la la la)",
            "duration": 95,
            "steps": 32,
            "cfg_strength": 6,
            "chunked": true,
            "tags": "rock and roll, hip hop",
            "negative_tags": "heavy metal, noise",
            "lrc_id": "b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1"
        },
        Prompt: {
            "prompt": "Take the input, and produce an Simple LRC format file which takes into account time required to sing the previous line. \n            Time tags have the format [mm:ss.xx]lyric , where mm is minutes, ss is seconds, xx is hundredths of a second, \n            and lyric is the lyric to be played at that time. Do not provide any other information. I require just the file.\n\n            Example output:\n\n            [00:12.00]Line 1 lyrics\n            [00:17.20]Line 2 lyrics",
            "model": "llama-3.2-3b-instruct",
            "category": "LRC",
            "is_default": true
        },
        SongStatus: {
            "id": "b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1",
            "title": "Banger #1",
            "filename": "s3://bucket/folder/song.wav",
            "dt_created": "2025-03-12T00:00:00+05:00",
            "processing_status": "NEW"
        },
        MusicGenerationResponse: {
            "id": "b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1"
        },
        GetLibraryResponse: {
            "library": [{
                "title": "Banger #1",
                "lyrics": "I am a song. (la la la)",
                "duration": 95,
                "steps": 32,
                "cfg_strength": 6,
                "chunked": true,
                "tags": "rock and roll, hip hop",
                "negative_tags": "heavy metal, noise",
                "lrc_id": "b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1"
            }]
        }
    }
};

const outputFile = './swagger-output.json';
const routes = ['./src/server/server.ts'];

swaggerAutogen(outputFile, routes, doc);