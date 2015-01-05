# should contain game logic
# should handle game loop and initiating server-side actions (NPC behavior)

'use strict'

class Game
  constructor: (@eventEmitter) ->
    @eventEmitter.on "msg", (socket, e, data) ->
      # read socket state, handle inbound message
      socket.state.handle socket, e, data

  # attaches transport to the game object for outbound messages
  setTransport: (@transport) ->

  # load up the world, probably going to have to use globals
  initWorld: ->

  # one of the things the game class needs to do is load some game data into memory that the client needs fast
  # this way we aren't pulling static data out of file reads on socket requests
  initData: ->
    # todo: compile names files into memory and attach to this game object

  # start the main game loop
  start: ->
    # init AI, make sure to be checking transport for active rooms

module.exports = Game
