# require auth lib, set on connect/disconnect events, should add to player list
# should contain an attached playerList Array
# should proxy broadcast and other socketio methods

class Transport
  constructor: (@socketio) ->


module.exports = exports = Transport