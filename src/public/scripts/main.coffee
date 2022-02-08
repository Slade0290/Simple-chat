import '../css/main.scss'
import Marionette from 'backbone.marionette'
import Backbone from 'backbone'
import UsernameFormView from 'views/usernameform'
import ProfilView from 'views/profil'
import LoginView from 'views/login'
import HomeView from 'views/home'
import ChatView from 'views/chat'
import io from 'socket.io-client'

app = new Marionette.Application
  region: '#main-container'
  onStart: ()->
    socket = io()
    # loginView = new LoginView
    # @showView loginView
    profilView = new ProfilView
    @showView profilView
    # homeView = new HomeView
    # @showView homeView
    # usernameform = new UsernameFormView
    # usernameform.on 'username:selected', (username)=>
    #   socket.emit 'set:username', username
    #   chatView = new ChatView
    #     collection: new Backbone.Collection()
    #     username: username
    #     socket: socket
    #   @showView chatView
    # @showView usernameform

app.start()
