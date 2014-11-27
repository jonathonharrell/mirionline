express = require "express"
config = require "./config/environment"

app = express()
server = require("http").createServer app
socketio = require("socket.io")(server, {
  serveClient: (config.env === 'production') ? false : true
  path: '/socket.io-client'
})

require("./init/socketio")(socketio)
require("./init/express")(app)

server.listen config.port, config.ip ->
  console.log "Express server listening on %d, in %s mode", config.port, app.get("env")

exports = module.exports = app