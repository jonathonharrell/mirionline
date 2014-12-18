'use strict'

angular.module 'mirionlineApp'
.controller 'CharacterSelectCtrl', ($scope, socketProvider, Auth) ->

  $scope.range = (n) -> new Array n

  socketProvider.socket.connect()

  socketProvider.socket.send "getCharacters", null, (characters) ->
    $scope.characters = characters
    $scope.empty = 2 - characters.length
