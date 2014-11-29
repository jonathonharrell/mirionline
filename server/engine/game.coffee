# should contain game logic
# should handle game loop and initiating server-side actions (NPC behavior)

'use strict'

auth = require "../lib/auth"

class Game
  constructor: (@eventEmitter) ->
    @eventEmitter.on "msg", (socket, e, data) ->
      # read socket state, handle inbound message
      console.info "%s %s", e, data
      # temp
      # in the future this needs to pass to socket.state.handle(e, data)
      if e is "login"
        auth.authenticate data.email, data.password, (err, token) ->
          socket.emit "authToken", err, token

      if e is "signup"
        auth.createUser data.user, (err, token) ->
          socket.emit "authToken", err, token

  # attaches transport to the game object for outbound messages
  setTransport: (@transport) ->

  # load up the world, probably going to have to use globals
  initWorld: ->

  # start the main game loop
  start: ->
    # init AI, make sure to be checking transport for active rooms

module.exports = Game