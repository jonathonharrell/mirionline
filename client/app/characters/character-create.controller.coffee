'use strict'

angular.module 'mirionlineApp'
.controller 'CharacterCreateCtrl', ($scope, socketProvider) ->
  socketProvider.socket.connect()
  $scope.character = {}

  socketProvider.socket.send "characterOptions", null, (struct) ->
    $scope.struct = struct
    $scope.randomizeCharacter()
    $scope.$watch "character.gender", ->
      $scope.character.firstName = _.sample $scope.struct.firstName.options[$scope.character.gender]

  $scope.createCharacter = ->
    socketProvider.socket.send "createCharacter", $scope.character
    return

  $scope.randomizeCharacter = ->
    $scope.character.gender    = _.sample $scope.struct.gender.options
    $scope.generateName()
    return

  $scope.generateName = ->
    unless $scope.firstNameLocked
      $scope.character.firstName = _.sample $scope.struct.firstName.options[$scope.character.gender]
    unless $scope.surnameLocked
      $scope.character.surname   = _.sample $scope.struct.surname.options
    return

  $scope.toggleLock = (field) ->
    $scope[field + "Locked"] = !$scope[field + "Locked"]
    return
