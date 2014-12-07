'use strict'

describe 'Directive: passwordStrength', ->

  # load the directive's module
  beforeEach module 'mirionlineApp'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<password-strength></password-strength>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the passwordStrength directive'
