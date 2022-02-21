debug = require('debug')('chat:lib:authentication')
libSocket = require 'lib/socket'
# event emitter
# handle Socket
export testDebug = ()->
  debug 'test'

export login = (user, password)->
  debug 'in login', user, password
  await libSocket.emitSocket 'login', user, password

export logout = ()->
  debug 'in logout'
