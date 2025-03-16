import express, { Request, Response } from 'express';
import { StatusController } from './status';
import { LibraryController } from './library';
import { PromptController } from './prompt';
import { MusicController } from './music';
const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('../../swagger-output.json');


const statusController = new StatusController();
const libraryController = new LibraryController();
const promptController = new PromptController();
const musicController = new MusicController();

const api = express();
api.use(express.json());


api.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  next();
});

api.use('/api/v1/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));


api.get('/api/v1/status/:id', (req, res) =>
  // #swagger.tags = ['Status']
  // #swagger.summary = 'Return inference status'
  // #swagger.description = 'This make a request against the inference server to determine if the song has finished process.'

  /* #swagger.responses[200] = {
            description: 'Get song status.',
            schema: { $ref: '#/definitions/SongStatus' }
    } */

  statusController.getStatus(req, res)
);

api.get('/api/v1/library', (req, res) =>
  // #swagger.tags = ['Library']
  // #swagger.summary = 'Returns a list of songs'
  // #swagger.description = 'This will return a list of all songs'

  /* #swagger.responses[200] = {
            description: 'Get a list of your songs.',
            schema: { $ref: '#/definitions/GetLibraryResponse' }
    } */

  libraryController.getLibrary(req, res));
api.post('/api/v1/library/song/:song/action/:acton', (req, res) =>
  // #swagger.tags = ['Library']
  // #swagger.summary = 'Performs an action against a song'
  // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

  /* #swagger.responses[200] = {
            description: 'Successfully update song',
    } */

  libraryController.performAction(req, res));

api.post('/api/v1/prompt', (req, res) =>
  // #swagger.tags = ['Prompt']
  // #swagger.summary = 'Updates a prompt'
  // #swagger.description = 'This allows you to update a prompt.'

  /*  #swagger.parameters['body'] = {
            in: 'body',
            description: 'Update a prompt.',
            schema: { $ref: '#/definitions/Prompt' }
    } */


  /* #swagger.responses[200] = {
  description: 'Successfully updated a prompt',
} */

  promptController.updatePrompt(req, res));

api.get('/api/v1/prompt/:id', (req, res) =>
  // #swagger.tags = ['Prompt']
  // #swagger.summary = 'Returns details on a prompt'
  // #swagger.description = 'This will return a prompt based on the id. If you pass LRC or POET it will return the system default prompt'

  /* #swagger.responses[200] = {
              description: 'Get a specific prompt.',
              schema: { $ref: '#/definitions/Prompt' }
      } */

  promptController.getPrompt(req, res));




api.post('/api/v1/music/generate', (req, res) =>
  // #swagger.tags = ['Music']
  // #swagger.summary = 'Submits a request to generate music'
  // #swagger.description = 'This API will make a request to the inference server to generate music'

  /*  #swagger.parameters['body'] = {
            in: 'body',
            description: 'Submits a song for generation.',
             schema: { $ref: '#/definitions/Song' }
    } */


  /* #swagger.responses[200] = {
              description: 'Successfully submitted a song for generation',
               schema: { $ref: '#/definitions/MusicGenerationResponse' }
      } */

  musicController.generate(req, res));


export function startServer(): void {
  api.listen(3000, () => {
    console.log('API server running on http://localhost:3000');
  })
}

