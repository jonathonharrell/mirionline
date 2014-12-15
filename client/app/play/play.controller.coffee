'use strict'

angular.module 'mirionlineApp'
.controller 'PlayCtrl', ($scope, socketProvider, Auth) ->
  socketProvider.socket.connect()
