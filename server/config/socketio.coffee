# Socket.io configuration

'use strict'

config = require "./environment"

module.exports = (socketio, transport) ->
  # socket.io (v1.x.x) is powered by debug.
  # In order to see all the debug output, set DEBUG (in server/config/local.env.js) to including the desired scope.
  #
  # ex: DEBUG: "http*,socket.io:socket"

  # We can authenticate socket.io users and access their token through socket.handshake.decoded_token
  #
  # 1. You will need to send the token in `client/components/socket/socket.service.js`
  #
  # 2. Require authentication here:
  socketio.use require("socketio-jwt").authorize
    secret: config.secrets.session,
    handshake: true

  socketio.on "connection", (socket) ->
    socket.address = (if (socket.handshake.address isnt null and socket.request.connection.remotePort) then socket.handshake.address.address + ":" + socket.request.connection.remotePort else process.env.DOMAIN)
    socket.connectedAt = new Date()

    # Call onDisconnect.
    socket.on "disconnect", ->
      transport.disconnect socket
      console.info "[%s] DISCONNECTED", socket.address

    # Call onConnect.
    transport.connect socket
    console.info "[%s] CONNECTED", socket.address
