'use strict'

auth = require "../../lib/auth"
User = require "../../model/user"
should = require "should"

user = new User
  email: "test@test.com"
  password: "password"

describe "Auth library", ->

  before (done) ->
    # clear users before tests
    User.remove().exec().then ->
      done()

  afterEach (done) ->
    User.remove().exec().then ->
      done()

  it "should begin with no users", (done) ->
    User.find {}, (err, users) ->
      users.should.have.length 0
      done()

  describe "getUsers method", ->

    it "should return an array of users", (done) ->
      auth.getUsers {}, (err, users) ->
        users.should.have.length 0
        done()

  describe "createUser method", ->

    it "should fail when saving a duplicate user", (done) ->
      userDup = new User user
      auth.createUser user, ->
        auth.createUser userDup, (err, token) ->
          should.exist err
          done()

    it "should return a token after successful save", (done) ->
      auth.createUser user, (err, token) ->
        should.exist token
        done()

  describe "getUser method", ->

    it "should return a user when one exists", (done) ->
      auth.createUser user, (err, token) ->
        auth.verifyToken token, (err, payload) ->
          auth.getUser payload._id, (err, user) ->
            should.exist user.email
            should.exist user._id
            done()

    it "should return nothing for no user found", (done) ->
      auth.getUser "41224d776a326fb40f000001", (err, user) ->
        should.not.exist err
        should.not.exist user
        done()

  describe "removeUser method", ->

    it "should remove a user record", (done) ->
      auth.createUser user, (err, token) ->
        auth.verifyToken token, (err, payload) ->
          id = payload._id
          auth.removeUser id, ->
            auth.getUser id, (err, user) ->
              should.not.exist user
              done()

  describe "verifyToken method", ->

    it "should return an object with an ID for a valid token", (done) ->
      auth.createUser user, (err, token) ->
        auth.verifyToken token, (err, payload) ->
          should.exist payload._id
          done()

  describe "changePassword method", ->

    it "should update the users password", (done) ->
      auth.createUser user, (err, token) ->
        auth.verifyToken token, (err, payload) ->
          auth.changePassword payload._id, "password", "password2", (err, user) ->
            user.authenticate("password").should.not.be.true
            user.authenticate("password2").should.be.true
            done()

  describe "authenticate method", ->

    before (done) ->
      auth.createUser user, (err, token) ->
        done()

    it "should authenticate against valid credentials", (done) ->
      auth.authenticate user.email, user.password, (err, token) ->
        should.exist token
        (err is null).should.be.true
        done()

    it "should fail for invalid credentials", (done) ->
      auth.authenticate user.email, "wrongpassword", (err, token) ->
        should.not.exist token
        should.exist err
        err.message.should.equal "Invalid credentials"
        done()

  describe "requireAuth middleware", ->

    it "should not pass through callback when an invalid token is supplied", (done) ->
      callback = ->
      auth.createUser user, (err, token) ->
        auth.requireAuth "", callback, ->
          done()

    it "should pass through to callback for valid token", (done) ->
      error_callback = ->
      auth.createUser user, (err, token) ->
        auth.requireAuth token, (payload) ->
          should.exist payload
          done()
        , error_callback
