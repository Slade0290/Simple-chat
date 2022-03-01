import Backbone from 'backbone'
import Socket from 'lib/socket'
import _ from 'lodash'
import moment from 'moment'
import Navigate from 'lib/navigate'
import Debug from 'debug'
debug = Debug 'chat:lib:authentication'
currentUser = null

export default Authentication = _.extend {}, Backbone.Events,

  signup: (user, password)->
    try
      res = await Socket.emit 'signup', user, password, moment()
      if res
        Navigate.toLogin()
      else
        debug 'signup fail'
        # show fail message
    catch error
      console.error 'Error during signup:', error

  login: (user, password)->
    try
      res = await Socket.emit 'login', user, password
      if res
        currentUser = res
        debug 'res', res
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
        Navigate.toLogin()
      else
        debug 'logout fail'
        # show fail message
    catch err
      console.error 'Error during logout:', err

  getCurrentUser: ->
    return currentUser

  isLoggedIn: ()->
    currentUser?

  updateUsername: (newUsername)->
    try
      resultUpdate = await Socket.emit 'update:username', newUsername
      if resultUpdate
        resultGet = await Socket.emit 'get:user', newUsername
        if resultGet
          currentUser = resultGet
        else
          debug 'get user fail'
      else
        debug 'update user fail'
    catch error
      console.error 'Error during update:', error

  updateUserAvatar: (avatar)->
    try
      resultUpdate = await Socket.emit 'update:avatar', currentUser.username, avatar
      if resultUpdate
        resultGet = await Socket.emit 'get:user', currentUser.username
        if resultGet
          currentUser = resultGet
        else
          debug 'get user fail'
      else
        debug 'update user fail'
    catch error
      console.error 'Error during user update:', error
