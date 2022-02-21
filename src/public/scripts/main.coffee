import '../css/main.scss'
import Marionette from 'backbone.marionette'
import Backbone from 'backbone'
import AppRouter from 'router'
import LoginView from 'views/login'
import io from 'socket.io-client'

app = new Marionette.Application
  region: '#main-container'
  onStart: (options)->
    router = new AppRouter @
    Backbone.history.start()
app.start()
