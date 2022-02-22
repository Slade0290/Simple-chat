debug = require('debug')('chat:lib:authentication')
Socket = require 'lib/socket'

export default Authentication =

  login: (user, password)->
    await Socket.default.emit 'login', user, password

  logout: ()->
    await Socket.default.emit 'logout', null

  # singleton event emitter
