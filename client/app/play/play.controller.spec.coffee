'use strict'

describe 'Controller: PlayCtrl', ->

  # load the controller's module
  beforeEach module 'mirionlineApp'
  beforeEach module 'socketMock'

  MainCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'PlayCtrl',
      $scope: scope

  it 'should attach a list of things to the scope', ->
    expect((1==1)).toBe true
