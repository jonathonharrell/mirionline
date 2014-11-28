# should contain game logic
# should handle game loop and initiating server-side actions (NPC behavior)
# 
# ?
# should have a list of players
# player should have state

'use strict'

class Game

  # should attach the transport layer for the game loop sending outbound messages
  # should register an event (require("events").EventEmitter) for handling all inbound messages
  setTransport: (transport) ->

  # load up the world, probably going to have to use globals
  initWorld: ->

  # start the main game loop
  start: ->