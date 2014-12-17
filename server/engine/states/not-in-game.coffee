'use strict'

State = require "../state"
User = require "../../api/user/user.model"

class NotInGameState extends State

  constructor: (user_id) ->
    self = this

    User.findByIdAsync user_id
      .then (user) ->
        self.player = user
        console.log self.player

  player: {}

  getCharacters: (socket) ->
    socket.emit "characters", @player.characters

  createCharacter: (socket, data) ->
    # validate data, then pass to select character to handle state transition

  selectCharacter: (socket, data) ->
    # validate data is correct character for user
    # transition to InGameState, provide user and selected character to constructor

module.exports = NotInGameState
