# require auth lib, set on connect/disconnect events, should add to player list
# should contain an attached list of sockets with IDs (game@transport.emitTo(:id, :message))
# should proxy broadcast and other socketio methods
# should concern itself with room subs and broadcast according to game commands accordingly
# list of rooms?

'use strict'

class Transport
  constructor: (@socketio) ->
    @socketio.on "connection", (socket) ->
      # add socket to list
      socket.address = ""
      if socket.handshake.address is not null and socket.request.connection.remotePort
        socket.address = socket.handshake.address.address + ":" + socket.request.connection.remotePort
      else
        socket.address = process.env.DOMAIN

      socket.connectedAt = new Date

      # Add ondisconnect event
      # Add init state
      # state should also attach room (socket.join)
      # add wildcard event that fires back to games listener with the socket and event

      socket.on "info", (data) ->
        console.info "[%s] %s", socket.address, JSON.stringify(data, null, 2)

      console.info '[%s] CONNECTED', socket.address
      @sockets.push socket

    # init global messaging service (socketio.emit)

  sockets: []

  # transport should switch socket to player object by character for whisper purposes
  players: {}

  # add method proxy broadcasting to room
  # add method proxy sending to unique user socketio.to(:id).emit()


module.exports = exports = Transport