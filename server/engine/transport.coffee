# require auth lib, set on connect/disconnect events, should add to player list
# should contain an attached list of sockets with IDs (game@transport.emitTo(:id, :message))
# should proxy broadcast and other socketio methods
# should concern itself with room subs and broadcast according to game commands accordingly
# list of rooms?

class Transport
  constructor: (@socketio) ->


module.exports = exports = Transport