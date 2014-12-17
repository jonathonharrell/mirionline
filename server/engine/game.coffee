# should contain game logic
# should handle game loop and initiating server-side actions (NPC behavior)

'use strict'

class Game
  constructor: (@eventEmitter) ->
    @eventEmitter.on "msg", (socket, e, data) ->
      # read socket state, handle inbound message
      console.info "%s %s", e, data
      socket.state.handle socket, e, data

  # attaches transport to the game object for outbound messages
  setTransport: (@transport) ->

  # load up the world, probably going to have to use globals
  initWorld: ->

  # start the main game loop
  start: ->
    # init AI, make sure to be checking transport for active rooms

module.exports = Game
