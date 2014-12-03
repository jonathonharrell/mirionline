'use strict'

app     = require "../../app"
User    = require "./user.model"

user = new User
  provider: 'local'
  email: 'test@test.com'
  password: 'password'

describe "User Model", ->
  before ->
    # Clear users before testing
    User.remove().exec()

  afterEach ->
    User.remove().exec()

  it "should begin with no users", ->
    User.findAsync({}).should.eventually.have.length 0

  it "should fail when saving a duplicate user", ->
    user.saveAsync().then(->
      userDup = new User user
      userDup.saveAsync()
    ).should.be.rejected

  it 'should fail when saving without an email', ->
    user.email = ''
    user.saveAsync().should.be.rejected

  it "should authenticate user if password is valid", ->
    user.authenticate('password').should.be.true

  it "should not authenticate user if password is invalid", ->
    user.authenticate('blah').should.not.be.true

  it "should not have salt or password properties", (done) ->
    user.email = 'test@test.com' # reset user email
    user.saveAsync().then (newUser) ->
      User.findAsync(newUser._id).then (user) ->
        user.should.not.have.property "salt"
        user.should.not.have.property "password"
        done()
