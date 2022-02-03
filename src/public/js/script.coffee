import '../css/style.scss'
import Marionette from 'backbone.marionette'
import Backbone from 'backbone'
import UsernameFormView from '../js/views/usernameform.coffee'
import ChatView from '../js/views/chat.coffee'
debug = require('debug')('worker:main')

debug 'Hello there I\'m the main debugger'
app = new Marionette.Application
app.addRegions
  main: '#main-container'

app.on 'start', ->
  usernameform = new UsernameFormView()
  app.getRegion('main').show usernameform
  usernameform.on 'username:selected', (username)->
    chatView = new ChatView({
      collection: new Backbone.Collection()
    , username: username})
    app.getRegion('main').show chatView

app.start()
