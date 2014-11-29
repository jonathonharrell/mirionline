# require auth lib, set on connect/disconnect events, should add to player list
# should contain an attached list of sockets with IDs (game@transport.emitTo(:id, :message))
# should proxy broadcast and other socketio methods
# should concern itself with room subs and broadcast according to game commands accordingly
# list of rooms?

'use strict'

class Transport
  constructor: (@socketio, @eventEmitter) ->
    @socketio.on "connection", (socket) ->
      # add socket to list
      socket.address = ""
      if socket.handshake.address and socket.request.connection.remotePort
        socket.address = socket.handshake.address.address + ":" + socket.request.connection.remotePort
      else
        socket.address = process.env.DOMAIN

      socket.connectedAt = new Date()

      socket.on "disconnect", ->
        console.info "[%s] DISCONNECTED", socket.address

      # Add init state
      # state should also attach room when necessary (socket.join)
      
      socket.on "msg", (e, data) ->
        eventEmitter.emit("msg", socket, e, data);

      console.info '[%s] CONNECTED', socket.address
      @sockets.push socket

  sockets: []

  # transport should switch socket to player object by character for whisper purposes
  players: {}

  # add method proxy broadcasting to room
  # add method proxy sending to unique user socketio.to(:id).emit()
  # add method proxying global message
  # add method for moving socket to players list when state change calls for it


module.exports = exports = Transport