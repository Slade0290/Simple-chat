import Backbone from 'backbone'
import LayoutView from 'views/layout'
import SignupView from 'views/signup'
import LoginView from 'views/login'
import ProfileView from 'views/profile'
import ChatView from 'views/chat'
import LogoutView from 'views/logout'
import HeaderUserSignupView from 'views/headerusersignup'
import HeaderUserLoggedView from 'views/headeruserlogged'
import io from 'socket.io-client'

export default class AppRouter extends Backbone.Router
  routes:
    '': 'showLogin'
    'signup': 'showSignupView'
    'profile': 'showProfileView'
    'chat': 'showChatView'
    'logout': 'showLogoutView'

  initialize: (@app)->
    @socket = io()
    console.log @socket
    @socket.on 'admin:info:connected', (user)=>
      @user = user
    @mainView = new LayoutView
    @app.showView(@mainView)

  showView: (childView, headerView)->
    console.log 'in showview @user', @user
    childView.on 'socket:emit', (message, args...)=>
      @socket.emit message, args...
    @mainView.showSubContainerView(childView)
    @mainView.showHeaderUserNavigation(headerView)

  showLogin: ->
    loginView = new LoginView
    @showView loginView, new HeaderUserSignupView

  showSignupView: ->
    signupView = new SignupView
    @showView signupView, new HeaderUserSignupView

  showProfileView: ->
    profileView = new ProfileView
    @showView profileView, new HeaderUserLoggedView
      model: new Backbone.Model({currentUser: @user})

  showChatView: ->
    chatView = new ChatView
      collection: new Backbone.Collection()
      socket: @socket
    @showView chatView, new HeaderUserLoggedView
      model: new Backbone.Model({currentUser: @user})

  showLogoutView: ->
    logoutView = new LogoutView
    @showView logoutView, new HeaderUserSignupView
