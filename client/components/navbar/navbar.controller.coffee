'use strict'

angular.module 'mirionlineApp'
.controller 'NavbarCtrl', ($scope, Auth) ->
  $scope.isCollapsed = true
  $scope.isLoggedIn = Auth.isLoggedIn
  $scope.isAdmin = Auth.isAdmin
  $scope.getCurrentUser = Auth.getCurrentUser
