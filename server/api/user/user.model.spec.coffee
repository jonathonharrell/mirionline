'use strict'

should = require "should"
app    = require "../../app"
User    = require "./user.model"

user = new User
  provider: 'local',
  email: 'test@test.com',
  password: 'password'

describe "User Model", ->
  before (done) -> 
    # Clear users before testing
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

  it 'should fail when saving without an email', (done) ->
    user.email = ''
    user.save (err) ->
      should.exist err
      done()

  it "should not have salt or hashedPassword properties", (done) ->
    user.save ->
      User.find {email: user.email}, (err, _user) ->
        _user.should.not.have.property "salt"
        _user.should.not.have.property "hashedPassword"
        done()

  it "should authenticate user if password is valid", ->
    user.authenticate('password').should.be.true

  it "should not authenticate user if password is invalid", ->
    user.authenticate('blah').should.not.be.true
