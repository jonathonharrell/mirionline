'use strict'

angular.module 'mirionlineApp'
.controller 'LoginCtrl', ($scope, Auth, $location) ->
  $scope.user = {}
  $scope.errors = {}
  $scope.login = (form) ->
    $scope.submitted = true

    if form.$valid
      # Logged in, redirect to home
      Auth.login
        email: $scope.user.email
        password: $scope.user.password

      , (err) ->
        $scope.errors.other = err.message if err
        $location.path '/' unless err
