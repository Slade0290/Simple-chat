import Backbone from 'backbone'
import Socket from 'lib/socket'
import _ from 'lodash'
import Debug from 'debug'
debug = Debug 'chat:lib:authentication'
currentUser = null

export default Authentication = _.extend {}, Backbone.Events,

  login: (user, password)->
    try
      res = await Socket.emit 'login', user, password
      if res
        currentUser = res
        @trigger('login', currentUser) # no need to trigger just use navigate module to go there
      else
        debug 'login fail'
        # show fail message
    catch err
      console.error 'Error during authentication: ', err

  logout: ->
    try
      res = await Socket.emit 'logout'
      if res
        currentUser = null
        @trigger('logout')
      else
        debug 'logout fail'
        # show fail message
    catch err
      console.error 'Error during authentication: ', err

  getCurrentUser: ->
    return currentUser

  isLoggedIn: ()->
    currentUser?
