debug = require('debug')('chat:lib:authentication')
Socket = require 'lib/socket'

export default class Authentication

  instance = null

  constructor: ->
    debug 'in constructor', instance
    if instance
      return instance
    instance = @

  testMethod: ->
    console.log 'testMethod'

  login: (user, password)->
    await Socket.default.emit 'login', user, password

  logout: ->
    await Socket.default.emit 'logout'
