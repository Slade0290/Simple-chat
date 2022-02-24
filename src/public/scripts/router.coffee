import Backbone from 'backbone'
import SignupView from 'views/signup'
import LoginView from 'views/login'
import ProfileView from 'views/profile'
import ChatView from 'views/chat'
import LayoutView from 'views/layout'
import Socket from 'lib/socket'
import Authentication from 'lib/authentication'
import Debug from 'debug'
debug = Debug 'chat:router'

export default class AppRouter extends Backbone.Router
  routes:
    '': 'showLoginView'
    'signup': 'showSignupView'
    'profile': 'showProfileView'
    'chat': 'showChatView'

  initialize: (@app)->
    debug 'in initialize'
    @user = null
    Authentication.on 'login', (user)=>
      @user = user
      debug 'in initialize on trigger user logged @user:', @user
      @showChatView() # not here
    Authentication.on 'logout', ()=>
      @showLoginView() # not here
    @mainView = new LayoutView
    @app.showView(@mainView)

  showView: (childView)->
    childView.on 'socket:emit', (message, args...)->
      await Socket.emit message, args...
    @mainView.showSubContainerView(childView)
    # @navigate()

  navigate: ()->
    debug 'in navigate @', @
    # Bb changing url

  showLoginView: ->
    debug 'in showLoginView @user', @user
    if @user
      @showChatView() # redirection should have chat in url
    else
      loginView = new LoginView
      @showView loginView

  showSignupView: ->
    signupView = new SignupView
    @showView signupView

  showProfileView: ->
    debug 'in showProfileView @user:', @user
    if @user
      profileView = new ProfileView
        model: new Backbone.Model({currentUser: @user})
      @showView profileView
    else
      @showLoginView()

  showChatView: ->
    debug 'in showChatView @user:', @user
    if @user
      chatView = new ChatView
        collection: new Backbone.Collection()
      @showView chatView
    else
      @showLoginView()
