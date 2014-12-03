"use strict"

User     = require "./user.model"
passport = require "passport"
config   = require "../../config/environment"
jwt      = require "jsonwebtoken"


validationError = (res, statusCode) ->
  statusCode = statusCode or 422
  return (err) -> res.status(statusCode).json(err)

handleError = (res, statusCode) ->
  statusCode = statusCode or 500
  return (err) -> res.send statusCode, err

respondWith = (res, statusCode) ->
  statusCode = statusCode or 200
  return () -> res.send statusCode

###*
Get list of users
restriction: 'admin'
###
exports.index = (req, res) ->
  User.findAsync {}
    .then (users) ->
      res.json 200, users
    .catch handleError(res)

###*
Creates a new user
###
exports.create = (req, res, next) ->
  newUser = new User req.body
  newUser.provider = "local"
  newUser.role = "user"

  newUser.saveAsync()
    .spread (user) ->
      token = jwt.sign { _id: user._id }, config.secrets.session, config.jwt_options
      res.json token: token
    .catch validationError(res)

###*
Get a single user
###
exports.show = (req, res, next) ->
  userId = req.params.id

  User.findByIdAsync(userId)
    .then (user) ->
      return res.send 404 unless user
      res.json user.profile
    .catch (err) ->
      next err

###*
Deletes a user
restriction: 'admin'
###
exports.destroy = (req, res) ->
  User.findByIdAndRemoveAsync req.params.id
    .then respondWith(res, 204)
    .catch handleError(res)


###*
Change a users password
###
exports.changePassword = (req, res, next) ->
  userId = req.user._id
  oldPass = String req.body.oldPassword
  newPass = String req.body.newPassword

  User.findByIdAsync userId
    .then (user) ->
      if user.authenticate oldPass
        user.password = newPass
        user.saveAsync()
          .then respondWith res, 200
          .catch validationError res
      else
        res.send 403

###*
Get my info
###
exports.me = (req, res, next) ->
  userId = req.user._id
  User.findOneAsync { _id: userId }
    .then (user) ->
      return res.status 401 unless user
      res.json user
    .catch (err) ->
      next err

###*
Authentication callback
###
exports.authCallback = (req, res, next) ->
  res.redirect "/"
