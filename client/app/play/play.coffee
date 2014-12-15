'use strict'

angular.module 'mirionlineApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'play',
    url: '/'
    templateUrl: 'app/play/play.html'
    controller: 'PlayCtrl'
    authenticate: true
    requiresCharacter: true
.run ($rootScope, Auth, $state) ->
  $rootScope.$on '$stateChangeStart', (event, next, nextParams, current) ->
    Auth.getCurrentUser (user) ->
      if next.requiresCharacter and not user.character
        $state.go "character-select"
