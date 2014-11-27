'use strict'

should = require "should"
User = require "../../model/user"
app = require "../../server"

user = new User
  email: "test@test.com"
  password: "password"

describe "User Model", ->

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

  it "should fail when saving a duplicate user", (done) ->
    user.save ->
      userDup = new User user
      userDup.save (err) ->
        should.exist err
        done()

  it "should fail when saving without email", (done) ->
    user.email = ''
    user.save (err) ->
      should.exist err
      done()

  it "should authenticate user if password is valid", ->
    user.authenticate("password").should.be.true

  it "should not authneticate if password is invalid", ->
    user.authenticate("blah").should.not.be.true