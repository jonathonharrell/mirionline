'use strict'

angular.module 'mirionlineApp'
.controller 'CharacterCreateCtrl', ($scope, socketProvider, Auth) ->
  socketProvider.socket.connect()

  $scope.createCharacter = (form) ->
    # do something!
    return
