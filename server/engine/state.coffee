# State should be attached to the socket

'use strict'

class State

  constructor: (socket) ->
    # do stuff related to socket
    # if we need to apply a room to the socket or anything else it would be here

  handle: (socket, e, data) ->
    # if we need to callback before each call, we would overwrite this method in the state
    this[e]? socket, data


module.exports = State
