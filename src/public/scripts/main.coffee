import '../css/main.scss'
import Marionette from 'backbone.marionette'
import Backbone from 'backbone'
import AppRouter from 'routers/router'
import LoginView from 'views/login'

app = new Marionette.Application
  region: '#main-container'
  onStart: (options)->
    loginView = new LoginView
    @showView loginView
    router = new AppRouter @
    Backbone.history.start()
    console.log 'router',router

app.start()
