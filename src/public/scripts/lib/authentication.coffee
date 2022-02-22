import Socket from 'lib/socket'
import Debug from 'debug'
debug = Debug 'chat:lib:authentication'
currentUser = null

export default Authentication =

  login: (user, password)->
    await Socket.emit 'login', user, password
    # set user

  logout: ->
    await Socket.emit 'logout'

  # get user method
