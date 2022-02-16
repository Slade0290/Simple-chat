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
    loginView.on 'socket:emit', (message, args...)=>
      @socket.emit message, args... # add this in every showview
    @app.showView loginView

  showSignupView: ->
    signupView = new SignupView
    signupView.on 'socket:emit', (message, args...)=>
      @socket.emit message, args... # add this in every showview
    @app.showView signupView

  showProfileView: ->
    profileView = new ProfileView
    @app.showView profileView

  showChatView: ->
    chatView = new ChatView
      collection: new Backbone.Collection()
      socket: @socket
    chatView.on 'socket:emit', (message, args...)=>
      @socket.emit message, args... # add this in every showview
    @app.showView chatView
