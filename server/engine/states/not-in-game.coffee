'use strict'

State = require "../state"
User  = require "../../api/user/user.model"
characterStruct = require "../structs/character"

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

  createCharacter: (socket, character) ->
    # validate data, then pass to select character to handle state transition

    # validations:
    # character.name (or other fields) must be present and must exist in the corresponding enum
    unless @player.characters.length < 2
      socket.emit "createCharacter", { error: "You already have the maximum number of characters." }
    console.log character

  selectCharacter: (socket, data) ->
    # validate data is correct character for user
    # transition to InGameState, provide user and selected character to constructor

  characterOptions: (socket) ->
    socket.emit "characterOptions", characterStruct
    # generate a list of character creation options for the client to use to generate a
    # character creation form

module.exports = NotInGameState
