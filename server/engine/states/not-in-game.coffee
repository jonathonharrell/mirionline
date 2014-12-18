'use strict'

State = require "../state"
User  = require "../../api/user/user.model"

class NotInGameState extends State

  # attach player object (user) to game state, to be stored in memory from now on
  constructor: (user_id) ->
    self = this

    User.findByIdAsync user_id
      .then (user) ->
        self.player = user

  player: {}

  getCharacters: (socket) ->
    # todo need to make sure there isn't a race condition with the query promise in the constructor
    socket.emit "getCharacters", @player.characters

  createCharacter: (socket, data) ->
    # validate data, then pass to select character to handle state transition
    console.log data

  selectCharacter: (socket, data) ->
    # validate data is correct character for user
    # transition to InGameState, provide user and selected character to constructor

  characterOptions: (socket) ->
    # generate a list of character creation options for the client to use to generate a
    # character creation form

  getName: (socket, data) ->
    # generate a name for a character based on male or female and first or surname
    # todo
    socket.emit "character-create.name", "TestName"

  # potentially accept name suggestions, or perform autocomplete

module.exports = NotInGameState
