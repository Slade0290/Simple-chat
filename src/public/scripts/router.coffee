import Backbone from 'backbone'
import SignupView from 'views/signup'
import LoginView from 'views/login'
import ProfileView from 'views/profile'
import ChatView from 'views/chat'
import LayoutView from 'views/layout'
import Socket from 'lib/socket'
import Authentication from 'lib/authentication'
import Navigate from 'lib/navigate'
import Debug from 'debug'
debug = Debug 'chat:router'

export default class AppRouter extends Backbone.Router
  routes:
    '': 'showLoginView'
    'signup': 'showSignupView'
    'profile': 'showProfileView'
    'chat': 'showChatView'

  initialize: (@app)->
    @mainView = new LayoutView
    @app.showView(@mainView)

  redirectUser: (view)->
    className = view.constructor.name
    isLogged = Authentication.isLoggedIn()
    if !isLogged and className isnt 'SignupView'
      return new LoginView
    else if isLogged and className isnt 'ProfileView'
      chatView = new ChatView
        collection: new Backbone.Collection()
      return chatView
    else
      return view

  showView: (childView)->
    view = @redirectUser(childView)
    @mainView.showSubview(view)

  showLoginView: ->
    loginView = new LoginView
    @showView loginView

  showSignupView: ->
    signupView = new SignupView
    @showView signupView

  showProfileView: ->
    profileView = new ProfileView
      model: new Backbone.Model({currentUser: Authentication.getCurrentUser()})
    @showView profileView

  showChatView: ->
    chatView = new ChatView
      collection: new Backbone.Collection()
    @showView chatView
