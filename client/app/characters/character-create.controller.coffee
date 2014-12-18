'use strict'

angular.module 'mirionlineApp'
.controller 'CharacterCreateCtrl', ($scope, socketProvider) ->
  socketProvider.socket.connect()
  $scope.character = {}

  $scope.createCharacter = ->
    socketProvider.socket.send "createCharacter", $scope.character
    return
