'use strict'

angular.module "mirionlineApp"
.factory "User", (socket, $q) ->

  get: (token) ->
    socket.socket.send "getUser", token

    deferred = $q.defer()

    socket.socket.on "user", (data) ->
      deferred.reject data.err if data.err or not data.user
      deferred.resolve data.user if data.user

    deferred.promise