express = require "express"
config = require "./config/environment"

app = express()
server = require("http").createServer app
socketio = require("socket.io")(server, {
  serveClient: if config.env is "production" then false else true
  path: "/socket.io-client"
})

Transport = require('./engine/transport')
transportLayer = new Transport socketio
require("./config/express")(app)

# init game, attach transport layer

server.listen config.port, config.ip, ->
  console.log "Express server listening on %d, in %s mode", config.port, app.get("env")

exports = module.exports = app