"use strict"

mongoose = require "mongoose"
Schema   = mongoose.Schema
crypto   = require "crypto"

UserSchema = new Schema
  name: String
  email:
    type: String
    lowercase: true
  role:
    type: String
    default: "user"
  hashedPassword: String
  provider: String
  salt: String

# Virtuals
UserSchema
.virtual("password").set (password) ->
  @_password = password
  @salt = @makeSalt()
  @hashedPassword = @encryptPassword password
  return
.get ->
  @_password

# Public profile information
UserSchema.virtual("profile").get ->
  name: @name
  role: @role

# Non-sensitive info we'll be putting in the token
UserSchema.virtual("token").get ->
  _id: @_id
  role: @role

# Validate empty email
UserSchema.path("email").validate (email) ->
  email.length
, "Email cannot be blank"

# Validate empty password
UserSchema.path("hashedPassword").validate (hashedPassword) ->
  hashedPassword.length
, "Password cannot be blank"

# Validate email is not taken
UserSchema.path("email").validate (value, respond) ->
  self = this
  @constructor.findOne
    email: value
  , (err, user) ->
    throw err  if err
    if user
      return respond(true)  if self.id is user.id
      return respond(false)
    respond true

, "The specified email address is already in use."

validatePresenceOf = (value) ->
  value and value.length

# Pre-save hook
UserSchema.pre "save", (next) ->
  return next()  unless @isNew
  unless validatePresenceOf(@hashedPassword)
    next new Error("Invalid password")
  else
    next()
  return

# Methods
UserSchema.methods =
  
  # Authenticate - check if the passwords are the same
  authenticate: (plainText) ->
    @encryptPassword(plainText) is @hashedPassword

  makeSalt: ->
    crypto.randomBytes(16).toString "base64"
  
  # Encrypt pass
  encryptPassword: (password) ->
    return ""  if not password or not @salt
    salt = new Buffer(@salt, "base64")
    crypto.pbkdf2Sync(password, salt, 10000, 64).toString "base64"


module.exports = mongoose.model("User", UserSchema)