'use strict'

app  = require "../../app"
User = require "./user.model"
request = require "supertest"


describe "User API:", ->
  user = undefined

  before (done) ->
    User.remove ->
      user = new User
        email: "test@test.com"
        password: "password"

      user.save (err) ->
        return done err if err
        done()

  after ->
    User.remove().exec()

  describe "GET /api/users/me", ->
    token = undefined

    before (done) ->
      request app
        .post "/auth/local"
        .send
          email: "test@test.com"
          password: "password"
        .expect 200
        .expect "Content-Type", /json/
        .end (err, res) ->
          token = res.body.token
          done()

    it "should respond with a user profile when authenticated", (done) ->
      request app
        .get "/api/users/me"
        .set "authorization", "Bearer " + token
        .expect 200
        .expect "Content-Type", /json/
        .end (err, res) ->
          res.body._id.toString().should.equal user._id.toString()
          done()

    it "should respond with a 401 when not authenticated", (done) ->
      request app
        .get "/api/users/me"
        .expect 401
        .end done
