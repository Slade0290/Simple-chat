import Socket from 'lib/socket'
import Debug from 'debug'
debug = Debug 'chat:lib:authentication'
currentUser = null

export default Authentication =

  login: (user, password)->
    currentUser = user
    await Socket.emit 'login', user, password

  logout: ->
    currentUser = null
    await Socket.emit 'logout'

  getCurrentUser: ->
    return currentUser
