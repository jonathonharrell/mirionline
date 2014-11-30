'use strict'

passport      = require("passport")
LocalStrategy = require("passport-local").Strategy

exports.setup = (User, config) ->
  passport.use new LocalStrategy(
    usernameField: "email"
    passwordField: "password" # this is the virtual field on the model
  , (email, password, done) ->
    User.findOne
      email: email.toLowerCase()
    , (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "Invalid credentials."
        )
      unless user.authenticate(password)
        return done(null, false,
          message: "Invalid credentials."
        )
      done null, user
  )
