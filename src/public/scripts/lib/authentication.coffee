import Backbone from 'backbone'
import Socket from 'lib/socket'
import _ from 'lodash'
import Navigate from 'lib/navigate'
import Debug from 'debug'
debug = Debug 'chat:lib:authentication'
currentUser = null

export default Authentication = _.extend {}, Backbone.Events,

  login: (user, password)->
    try
      res = await Socket.emit 'login', user, password
      if res
        currentUser = res
        @trigger 'login', currentUser
        Navigate.to 'chat'
      else
        debug 'login fail'
        # show fail message
    catch err
      console.error 'Error during authentication: ', err

  logout: ->
    try
      res = await Socket.emit 'logout'
      if res
        @trigger 'logout', currentUser
        currentUser = null
        Navigate.to ''
      else
        debug 'logout fail'
        # show fail message
    catch err
      console.error 'Error during authentication: ', err

  getCurrentUser: ->
    return currentUser

  isLoggedIn: ()->
    currentUser?
