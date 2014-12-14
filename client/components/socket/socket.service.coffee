# global io

'use strict'

angular.module 'mirionlineApp'
.factory 'socket', (socketFactory, Auth) ->

  # socket.io now auto-configures its connection when we omit a connection url
  ioSocket = io '',
    # Send auth token on connection, you will need to DI the Auth service above
    'query': 'token=' + Auth.getToken()
    path: '/socket.io-client'

  socket = socketFactory ioSocket: ioSocket

  Auth.attachSocket socket

  socket: socket

