'use strict'

mongoose = require "mongoose"
Schema = mongoose.Schema
crypto = require "crypto"

validatePresenceOf = (val) ->
  val and val.length

UserSchema = new Schema 
  email: 
    type: String
    lowercase: true
  role:
    type: String
    default: "user"
  hashedPassword: String
  salt: String

UserSchema
  .virtual "password"
  .set (password) ->
    @_password = password
    @salt = @makeSalt()
    @hashedPassword = @encrypt password
  .get ->
    @_password

# non-sensitive info we'll be putting into the JSON token
UserSchema
  .virtual "token"
  .get ->
    { _id: @_id, role: @role }

#
# Validations
# 

UserSchema
  .path "email"
  .validate (email) -> 
    email.length
  , "Email is required."

UserSchema
  .path "hashedPassword"
  .validate (hashedPassword) ->
    hashedPassword.length
  , "Password is required."

UserSchema
  .path "email"
  .validate (val, respond) ->
    self = this
    @constructor.findOne {email: val}, (err, user) ->
      throw err if err

      if user
        return respond true if self.id is user.id
        return respond false

      respond true

# Pre save
UserSchema
  .pre "save", (next) ->
    return next() unless @isNew
    return next new Error "Invalid Password" unless validatePresenceOf @hashedPassword
    next()

UserSchema.methods =
  authenticate: (plainText) ->
    this.encrypt(plainText) is @hashedPassword

  makeSalt: ->
    crypto.randomBytes(16).toString "base64"

  encrypt: (password) ->
    return "" unless password and @salt
    salt = new Buffer @salt, "base64"
    crypto.pbkdf2Sync(password, salt, 10000, 64).toString "base64"


module.exports = mongoose.model "User", UserSchema