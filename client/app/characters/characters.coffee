'use strict'

angular.module 'mirionlineApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'character-select',
    url: '/characters'
    templateUrl: 'app/characters/character-select.html'
    controller: 'CharacterSelectCtrl'
    authenticate: true

  .state 'character-create',
    url: '/characters/create'
    templateUrl: 'app/characters/character-create.html'
    controller: 'CharacterCreateCtrl'
    authenticate: true
