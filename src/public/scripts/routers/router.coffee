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
    loginView.on 'submit:login:credential', (email, password, callback)=>
      @socket.emit 'login',email, password, callback
    @app.showView loginView
    # use router show view & listener

  showSignupView: ->
    signupView = new SignupView
    signupView.on 'submit:new:credential', (email, password, callback)=>
      @socket.emit 'signup', email, password1, callback
    @app.showView signupView

  showProfileView: ->
    profileView = new ProfileView
    @app.showView profileView

  showChatView: ->
    chatView = new ChatView
      collection: new Backbone.Collection()
      socket: @socket
    @app.showView chatView
