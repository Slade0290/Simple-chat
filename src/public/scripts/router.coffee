import Backbone from 'backbone'
import SignupView from 'views/signup'
import LoginView from 'views/login'
import ProfileView from 'views/profile'
import ChatView from 'views/chat'
import LogoutView from 'views/logout'
import LayoutView from 'views/layout'
Socket = require 'lib/socket'
debug = require('debug')('chat:router')

export default class AppRouter extends Backbone.Router
  routes:
    '': 'showLoginView'
    'signup': 'showSignupView'
    'profile': 'showProfileView'
    'chat': 'showChatView'
    'logout': 'showLogoutView'

  initialize: (@app)->
    Socket.default.on 'user:logged', (user)=>
      @user = user
      @showChatView() # not here
    @mainView = new LayoutView
    @app.showView(@mainView)

  showView: (childView)->
    childView.on 'socket:emit', (message, args...)=>
      await libSocket.emitSocket message, args...
    @mainView.showSubContainerView(childView)

  showLoginView: ->
    if @user
      @showChatView()
    else
      loginView = new LoginView
      @showView loginView

  showSignupView: ->
    signupView = new SignupView
    @showView signupView

  showProfileView: ->
    if @user
      profileView = new ProfileView
        model: new Backbone.Model({currentUser: @user})
      @showView profileView
    else
      @showLoginView()

  showChatView: ->
    if @user
      chatView = new ChatView
        collection: new Backbone.Collection()
      @showView chatView
    else
      @showLoginView()

  showLogoutView: -> # change to action
    @user = null
    Socket.default.emit 'user:logout'
    logoutView = new LogoutView
    @showView logoutView
