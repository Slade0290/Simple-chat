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

  showView: (childView)->
    @mainView.showSubview(childView)

  showLoginView: ->
    loginView = new LoginView
    @showView loginView
    Navigate.to('')

  showSignupView: ->
    signupView = new SignupView
    @showView signupView
    Navigate.to('signup')

  showProfileView: ->
    profileView = new ProfileView
      model: new Backbone.Model({currentUser: Authentication.getCurrentUser()})
    @showView profileView
    Navigate.to('profile')

  showChatView: ->
    chatView = new ChatView
      collection: new Backbone.Collection()
    @showView chatView
    Navigate.to('chat')
