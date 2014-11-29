'use strict'

User = require "../model/user"
config = require "../config/environment"
jwt = require "jsonwebtoken"

# get list of users, proxy for User.find
# admin only
getUsers = (query, callback) ->
  User.find query, "-salt -hashedPassword", callback

# create user, return callback(err, token)
createUser = (user, callback) ->
  newUser = new User user
  newUser.save (err, user) ->
    return callback err if err
    token = jwt.sign { _id: user._id }, config.secrets.session, config.session.options
    callback null, token

# proxy over user model findById method
getUser = (id, callback) ->
  User.findById id, "-salt -hashedPassword", callback

# remove a user and return an error if a callback is provided
# admin only
removeUser = (id, callback) ->
  unless callback 
    callback = ->
  User.findByIdAndRemove id, callback

# Proxy for JWT token digest
verifyToken = (token, callback) ->
  jwt.verify token, config.secrets.session, callback

# Update password for account
changePassword = (id, oldPassword, newPassword, callback) ->
  User.findById id, (err, user) ->
    return callback { message: "Invalid permissions" } unless user.authenticate(oldPassword)

    user.password = newPassword
    user.save (err, user) ->
      return callback err if err
      callback null, user

# authenticate a user (usually reserved for login)
authenticate = (email, password, callback) ->
  User.findOne { email: email.toLowerCase() }, (err, user) ->
    return callback err if err
    return callback { message: "Invalid credentials" } unless user
    return callback { message: "Invalid credentials" } unless user.authenticate password

    token = jwt.sign { _id: user._id }, config.secrets.session, config.session.options
    return callback null, token

# auth hook
requireAuth = (token, callback, error_callback) ->
  verifyToken token, (err, payload) ->
    return error_callback err if err or not payload
    return callback payload


exports.getUsers       = getUsers
exports.getUser        = getUser
exports.createUser     = createUser
exports.removeUser     = removeUser
exports.verifyToken    = verifyToken
exports.changePassword = changePassword
exports.authenticate   = authenticate
exports.requireAuth    = requireAuth