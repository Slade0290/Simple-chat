import '../css/style.scss'
import Marionette from 'backbone.marionette'
import Backbone from 'backbone'
import UsernameFormView from 'views/usernameform'
import ChatView from 'views/chat'
import io from 'socket.io-client'

app = new Marionette.Application
app.addRegions
  main: '#main-container'

app.on 'start', ->
  socket = io()
  usernameform = new UsernameFormView()
  usernameform.on 'username:selected', (username)->
    socket.emit 'set:username', username
    chatView = new ChatView
      collection: new Backbone.Collection()
      username: username
      socket: socket
    app.getRegion('main').show chatView
  app.getRegion('main').show usernameform

app.start()
