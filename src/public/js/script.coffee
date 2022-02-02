import '../css/style.scss'
import Marionette from 'backbone.marionette'
import ChatView from '../js/views/chat'
debug = require('debug')('worker:main')

debug 'Hello there I\'m the main debugger'
app = new Marionette.Application
app.addRegions
  main: '#main-container'

app.on 'start', ->
  chatView = new ChatView({
    collection: new Backbone.Collection()
  })
  app.getRegion('main').show chatView
app.start()
