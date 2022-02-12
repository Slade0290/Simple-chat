Backbone = require 'backbone'
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

  showLogin: ->
    loginView = new LoginView
      socket: @socket
    @app.showView loginView

  showSignupView: ->
    signupView = new SignupView
      socket: @socket
    @app.showView signupView

  showProfileView: ->
    profileView = new ProfileView
    @app.showView profileView

  showChatView: ->
    chatView = new ChatView
      collection: new Backbone.Collection()
      socket: @socket
    @app.showView chatView
