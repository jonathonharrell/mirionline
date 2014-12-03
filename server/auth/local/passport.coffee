'use strict'

passport      = require("passport")
LocalStrategy = require("passport-local").Strategy

localAuthenticate = (User, email, password, done) ->
  User.findOneAsync
    email: email.toLowerCase()
  , "+salt +password"
  .then (user) ->
    return done null, false, { message: "Invalid credentials." } unless user

    user.authenticate password, (authError, authenticated) ->
      return done authError if authError
      return done null, false, { message: "Invalid credentials" } unless authenticated

      done null, user
  .catch (err) ->
    done err

exports.setup = (User, config) ->
  passport.use new LocalStrategy(
    usernameField: "email"
    passwordField: "password"
  , (email, password, done) ->
    localAuthenticate User, email, password, done
  )
