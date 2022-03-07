const http = require('http');
const express = require('express');
const compression = require('compression');
const helmet = require('helmet');
const { createTerminus } = require('@godaddy/terminus');
require('dotenv').config();

const winston = require('winston');
const expressWinston = require('express-winston');
const app = express();

const { NODE_ENV, PORT } = process.env;
const isProductionMode = NODE_ENV === 'production';
const winstonConfig = {
  level: isProductionMode ? 'http' : 'debug',
  transports: [new winston.transports.Console()],
  format: winston.format.json(),
};

const logger = winston.createLogger(winstonConfig);

app.use(expressWinston.logger(winstonConfig));
app.use(helmet());
app.use(compression());

const port = PORT || 3000;

app.get('/hello', (req, res) => {
  res.json({ message: 'Hello World!' });
});

const server = http.createServer(app);

function onSignal() {
  logger.info('Server is starting cleanup');
}

async function onHealthCheck() {
  return Promise.resolve();
}

createTerminus(server, {
  signal: 'SIGINT',
  healthChecks: { '/healthcheck': onHealthCheck },
  onSignal,
});

server.listen(port, () => {
  logger.info(`Hello World listening on port ${port}`);
});
