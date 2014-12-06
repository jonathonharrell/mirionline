"use strict"

mongoose = require("mongoose-bird")()
Schema   = mongoose.Schema
crypto   = require "crypto"

UserSchema = new Schema
  email:
    type: String
    lowercase: true
  role:
    type: String
    default: "user"
  password:
    type: String
    select: false
  provider: String
  salt:
    type: String
    select: false

# Virtuals

# Public profile information
UserSchema.virtual("profile").get ->
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
UserSchema.path("password").validate (password) ->
  password.length
, "Password cannot be blank"

# Validate email is not taken
UserSchema.path("email").validate (value, respond) ->
  self = this
  @constructor.findOneAsync email: value
    .then (user) ->
      if user
        return respond true if self.id is user.id
        return respond false
      respond true
    .catch (err) ->
      throw err
, "The specified email address is already in use."

validatePresenceOf = (value) ->
  value and value.length

# Pre-save hook
UserSchema.pre "save", (next) ->
  if @password
    return next new Error("Invalid password") unless validatePresenceOf(@password)

    _this = this
    @makeSalt (saltErr, salt) ->
      return next saltErr if saltErr
      _this.salt = salt
      _this.encryptPassword _this.password, (encryptErr, hashedPassword) ->
        return next encryptErr if encryptErr
        _this.password = hashedPassword
        next()
  else
    next()


# Methods
UserSchema.methods =

  # Authenticate - check if the passwords are the same
  authenticate: (password, callback) ->
    return @encryptPassword(password) is @password unless callback

    _this = this
    @encryptPassword password, (err, pwdGen) ->
      return callback err if err
      if pwdGen is _this.password
        callback null, true
      else
        callback null, false

    return

  makeSalt: (byteSize, callback) ->
    defaultByteSize = 16

    if typeof arguments[0] is "function"
      callback = arguments[0]
      byteSize = defaultByteSize
    else callback = arguments[1] if typeof arguments[1] is "function"

    byteSize = defaultByteSize unless byteSize

    return crypto.randomBytes(byteSize).toString "base64" unless callback
    crypto.randomBytes byteSize, (err, salt) ->
      return callback err if err
      callback null, salt.toString "base64"

  # Encrypt pass
  encryptPassword: (password, callback) ->
    return null if not password or not @salt

    defaultIterations = 10000
    defaultKeyLength = 64
    salt = new Buffer @salt, "base64"

    return crypto.pbkdf2Sync(password, salt, defaultIterations, defaultKeyLength).toString "base64" unless callback

    crypto.pbkdf2 password, salt, defaultIterations, defaultKeyLength, (err, key) ->
      return callback err if err
      callback null, key.toString "base64"


module.exports = mongoose.model "User", UserSchema
