import Backbone from 'backbone'
import SignupView from 'views/signup'
import LoginView from 'views/login'
import ProfileView from 'views/profile'
import ChatView from 'views/chat'
import LayoutView from 'views/layout'
import Socket from 'lib/socket'
import Debug from 'debug'
debug = Debug 'chat:router'

export default class AppRouter extends Backbone.Router
  routes:
    '': 'showLoginView'
    'signup': 'showSignupView'
    'profile': 'showProfileView'
    'chat': 'showChatView'

  initialize: (@app)->
    Socket.on 'user:logged', (user)=>
      @user = user # handle user in authentication
      @showChatView() # not here

    Socket.on 'user:logout', (value)=>
      @user = null # handle user in authentication
      @showLoginView() # not here
    @mainView = new LayoutView
    @app.showView(@mainView)

  showView: (childView)->
    childView.on 'socket:emit', (message, args...)=>
      await Socket.emit message, args...
    @mainView.showSubContainerView(childView)

  showLoginView: ->
    if @user
      @showChatView() # redirection should have chat in url
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
