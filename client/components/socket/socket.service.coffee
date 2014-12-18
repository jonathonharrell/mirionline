# global io

'use strict'

angular.module 'mirionlineApp'
.factory 'socketProvider', (socketFactory, Auth) ->

  # socket.io now auto-configures its connection when we omit a connection url
  ioSocket = io '',
    # Send auth token on connection, you will need to DI the Auth service above
    'query': 'token=' + Auth.getToken()
    path: '/socket.io-client'

  socket = socketFactory ioSocket: ioSocket

  socket.send = (e, data, callback) -> # two way message (emulate HTTP), useful for certain things
    socket.emit "msg", e, data
    socket.on e, callback if callback

  socket: socket

