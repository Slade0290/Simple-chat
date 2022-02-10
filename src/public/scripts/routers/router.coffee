Backbone = require 'backbone'
import RegisterView from 'views/register'
import LoginView from 'views/login'
import ProfileView from 'views/profile'
import ChatView from 'views/chat'
import io from 'socket.io-client'

export default class AppRouter extends Backbone.Router
  routes:
    '': 'showLogin'
    'register': 'showRegisterView'
    'profile': 'showProfileView'
    'chat': 'showChatView'

  initialize: (@app)->
    @socket = io()

  showLogin: ->
    loginView = new LoginView
    @app.showView loginView

  showRegisterView: ->
    registerView = new RegisterView
    @app.showView registerView

  showProfileView: ->
    profileView = new ProfileView
    @app.showView profileView

  showChatView: ->
    chatView = new ChatView
      collection: new Backbone.Collection()
      socket: @socket
    @app.showView chatView
