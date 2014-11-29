'use strict'

express = require "express"
mongoose = require "mongoose"
config = require "./config/environment"

# connect to MongoDB
mongoose.connect config.mongo.uri, config.mongo.options

app = express()
server = require("http").createServer app
socketio = require("socket.io")(server, {
  serveClient: if config.env is "production" then false else true
  path: "/socket.io-client"
})

EventEmitter = require("events").EventEmitter
eventEmitter = new EventEmitter()

Game = require './engine/game'
game = new Game(eventEmitter)

Transport = require('./engine/transport')
transportLayer = new Transport socketio, eventEmitter
require("./config/express")(app)

# bootstrap static routes
app.route('/:url(api|auth|components|app|bower_components|assets)/*').get (req, res) ->
  res.sendStatus 404

app.route('/*').get (req, res) ->
  res.sendfile app.get('appPath') + '/index.html'

# init game, attach transport layer

server.listen config.port, config.ip, ->
  console.log "Express server listening on %d, in %s mode", config.port, app.get("env")

exports = module.exports = app