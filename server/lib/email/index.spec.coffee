'use strict'

mailer = require "./"

describe "Email transport", ->

  m = undefined
  e =
    template: "registered"
    to: "test@test.com"
    locals:
      user: {}

  before ->
    m = mailer()

  it "should return a transport", ->
    expect(m).to.have.property 'sendMessage'
    expect(m).to.have.property 'sendMail'

  it "should send a test email", (done) ->
    m.sendMessage e, (err, data) ->
      expect(err).to.be.null
      expect(data.response).to.exist
      done()

  it "should fail gracefully if the template does not exist", (done) ->
    e.template = "not-a-real-template"
    m.sendMessage e, (err, data) ->
      expect(err).not.to.be.null
      expect(data).to.be.falsy
      done()
