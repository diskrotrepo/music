import express, { Request, Response } from 'express';
import { StatusController } from './status';
import { LibraryController } from './library';
import { PromptController } from './prompt';
import { MusicController } from './music';
const swaggerUi = require('swagger-ui-express');
//const swaggerDocument = require('./swagger.json');


const statusController = new StatusController();
const libraryController = new LibraryController();
const promptController = new PromptController();
const musicController = new MusicController();

const api = express();


api.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  next();
});

//api.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));


api.get('/api/v1/status/:id', (req, res) => statusController.getStatus(req, res));

api.get('/api/v1/library', (req, res) => libraryController.getLibrary(req, res));
api.post('/api/v1/library/song/:song/action/:acton', (req, res) => libraryController.performAction(req, res));

api.post('/api/v1/prompt', (req, res) => promptController.updatePrompt(req, res));
api.get('/api/v1/prompt/:id', (req, res) => promptController.getPrompt(req, res));


api.post('/api/v1/music/generate', (req, res) => musicController.generate(req, res));


export function startServer(): void {
  api.listen(3000, () => {
    console.log('API server running on http://localhost:3000');
  })
}

