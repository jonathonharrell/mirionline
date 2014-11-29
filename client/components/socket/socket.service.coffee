# global io

'use strict'

angular.module 'mirionlineApp'
.factory 'socket', (socketFactory) ->

  ioSocket = io '',
    path: '/socket.io-client'

  socket = socketFactory ioSocket: ioSocket

  socket.send = (e, data) ->
    socket.emit "msg", e, data

  socket: socket
