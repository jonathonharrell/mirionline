'use strict'

angular.module "mirionlineApp"
.factory "User", (socket, $q) ->

  get: (token) ->
    deferred = $q.defer()
    socket.socket.send "getUser", token

    socket.socket.on "user", (err, user) ->
      deferred.reject err if err or not user
      deferred.resolve user if user

    deferred.promise