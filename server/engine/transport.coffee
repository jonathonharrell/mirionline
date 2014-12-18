# set on connect/disconnect events, should add to player list
# should contain an attached list of sockets with IDs (game@transport.emitTo(:id, :message))
# should proxy broadcast and other socketio methods
# should concern itself with room subs and broadcast according to game commands accordingly
# list of rooms?

'use strict'

NotInGameState = require "./states/not-in-game"

class Transport
  # attach event emitter instance
  constructor: (@eventEmitter) ->

  # run on socketio connection
  connect: (socket) ->
      # handle setting to authenticated if token is passed for connection
      socket.state = new NotInGameState(socket.decoded_token._id)
      # state should also attach room when necessary (socket.join)

      self = this
      socket.on "msg", (e, data) ->
        self.eventEmitter.emit("msg", socket, e, data);

      @sockets.push socket

  disconnect: (socket) ->
    # do something with a disconnection (fire an event back to game to wait a certain amount of time and remove them from the players list)

  sockets: []

  # transport should switch socket to player object by character for whisper purposes
  players: {}

  # add method proxy broadcasting to room
  # add method proxy sending to unique user socketio.to(:id).emit()
  # add method proxying global message
  # add method for moving socket to players list when state change calls for it

module.exports = exports = Transport
