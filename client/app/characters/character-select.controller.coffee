'use strict'

angular.module 'mirionlineApp'
.controller 'CharacterSelectCtrl', ($scope, socketProvider, Auth) ->
  socketProvider.socket.connect()
