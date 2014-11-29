'use strict'

angular.module "mirionlineApp"
.factory "Auth", ($cookieStore, User, socket) ->
  token = $cookieStore.get("token") or null
  currentUser = if token then User.get token else {}

  # Authenticate user and save token
  login: (user, callback) ->
    socket.socket.send 'login',
      email: user.email
      password: user.password

    socket.socket.on 'authToken', (err, token) ->
      return callback? err if err
      $cookieStore.put 'token', token
      currentUser = User.get token
      callback?()

  # remove user token
  logout: ->
    $cookieStore.remove 'token'
    currentUser = {}
    return

  # Create a new user
  createUser: (user, callback) ->
    data = {user: user}
    socket.socket.send 'signup', data

    socket.socket.on 'authToken', (err, token) ->
      return callback? err if err
      $cookieStore.put 'token', token
      currentUser = User.get token
      callback?()

  # Change Password
  changePassword: (oldPassword, newPassword, callback) ->
    socket.socket.send 'change-password', oldPassword, newPassword

  # get current user
  getCurrentUser: ->
    currentUser

  # check if user is logged in async
  isLoggedIn: ->
    currentUser.hasOwnProperty 'role'

  # Waits for currentUser to resolve before checking if user is logged in
  isLoggedInAsync: (callback) ->
    if currentUser.hasOwnProperty '$promise'
      currentUser.$promise.then ->
        callback? true
        return
      .catch ->
        callback? false
        return

    else
      callback? currentUser.hasOwnProperty 'role'

  # Check if a user is an admin
  isAdmin: ->
    currentUser.role is 'admin'

  # Get auth token
  getToken: ->
    $cookieStore.get 'token'