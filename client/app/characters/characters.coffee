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
    abstract: true
    authenticate: true

  .state 'character-create.history',
    url: '/history'
    templateUrl: 'app/characters/create/history.html'
    authenticate: true

  .state 'character-create.aesthetics',
    url: '/aesthetics'
    templateUrl: 'app/characters/create/aesthetics.html'
    authenticate: true

  .state 'character-create.name',
    url: '/finish'
    templateUrl: 'app/characters/create/name.html'
    authenticate: true
