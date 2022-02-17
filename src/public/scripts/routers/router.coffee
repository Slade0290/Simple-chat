Backbone = require 'backbone'
import MainView from 'views/main'
import SignupView from 'views/signup'
import LoginView from 'views/login'
import ProfileView from 'views/profile'
import ChatView from 'views/chat'
import io from 'socket.io-client'

export default class AppRouter extends Backbone.Router
  routes:
    '': 'showLogin'
    'signup': 'showSignupView'
    'profile': 'showProfileView'
    'chat': 'showChatView'

  initialize: (@app)->
    @socket = io()

  showView: (childView)->
    mainView = new MainView
    childView.on 'socket:emit', (message, args...)=>
      @socket.emit message, args...
    mainView.showChildView('subRegion', childView)
    @app.showView(mainView)

  showLogin: ->
    loginView = new LoginView
    @showView loginView

  showSignupView: ->
    signupView = new SignupView
    @showView signupView

  showProfileView: ->
    profileView = new ProfileView
    @app.showView profileView

  showChatView: ->
    chatView = new ChatView
      collection: new Backbone.Collection()
      socket: @socket
    @showView chatView
