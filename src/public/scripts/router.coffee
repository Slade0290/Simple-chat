import Backbone from 'backbone'
import SignupView from 'views/signup'
import LoginView from 'views/login'
import ProfileView from 'views/profile'
import ChatView from 'views/chat'
import LogoutView from 'views/logout'
import LayoutView from 'views/layout'
import HeaderUserSignupView from 'views/layout/headerusersignup'
import HeaderUserLoggedView from 'views/layout/headeruserlogged'
import io from 'socket.io-client'
libSocket = require 'lib/socket'
debug = require('debug')('chat:router')

export default class AppRouter extends Backbone.Router
  routes:
    '': 'showLoginView'
    'signup': 'showSignupView'
    'profile': 'showProfileView'
    'chat': 'showChatView'
    'logout': 'showLogoutView'

  initialize: (@app)->
    @socket = io()
    console.log @socket
    @socket.on 'admin:info:login', (user)=>
      @user = user
      console.log 'in initialize router @user', @user
    @mainView = new LayoutView
    @app.showView(@mainView)

  showView: (childView, headerView)->
    console.log 'in showview @user', @user
    childView.on 'socket:emit', (message, args...)=>
      console.log 'in socket emit router', message
      await libSocket.emitSocket message, args...
    @mainView.showSubContainerView(childView)
    @mainView.showHeaderUserNavigation(headerView)

  showLoginView: ->
    if @user
      @showChatView()
    else
      loginView = new LoginView
      @showView loginView, new HeaderUserSignupView

  showSignupView: ->
    signupView = new SignupView
    @showView signupView, new HeaderUserSignupView

  showProfileView: ->
    if @user
      profileView = new ProfileView
        model: new Backbone.Model({currentUser: @user})
      @showView profileView, new HeaderUserLoggedView # should not be that
        model: new Backbone.Model({currentUser: @user})
    else
      @showLoginView()

  showChatView: ->
    if @user
      chatView = new ChatView
        collection: new Backbone.Collection()
        socket: @socket
      @showView chatView, new HeaderUserLoggedView
        model: new Backbone.Model({currentUser: @user})
    else
      @showLoginView()

  showLogoutView: -> # change to action
    @user = null
    @socket.emit 'user:logout'
    logoutView = new LogoutView
    @showView logoutView, new HeaderUserSignupView
