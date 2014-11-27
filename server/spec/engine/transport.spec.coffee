should = require "should"
Transport = require "../../engine/transport"
transport = new Transport {
  on: (cb) ->
    cb()
}

describe "Transport class", ->

  it "should attach a socketio object", (done) ->
    transport.socketio.on ->
      done()