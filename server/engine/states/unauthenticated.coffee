'use strict'

State = require "../state"
auth = require "../../lib/auth"

class Unauthenticated extends State

  login: (socket, data) ->
    auth.authenticate data.email, data.password, (err, token) ->
      socket.emit "authToken", err, token

  signup: (socket, data) ->
    auth.createUser data.user, (err, token) ->
      socket.emit "authToken", err, token

  getUser: (socket, data) ->
    auth.verifyToken data, (err, payload) ->
      auth.getUser payload._id, (err, user) ->
        socket.emit "user", err, user
        socket.user = user if user and not err

module.exports = Unauthenticated