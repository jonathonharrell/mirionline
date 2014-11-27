should = require "should"
Transport = require "../../engine/transport"

# mock socketio object
transport = new Transport {
  on: ->
}

describe "Transport class", ->

  it "should attach a socketio object", ->
    transport.socketio.should.exist

  it "should have an array of socket objects", ->
    transport.sockets.should.exist
    transport.sockets.length.should.exist