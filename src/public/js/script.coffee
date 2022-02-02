import '../css/style.scss'
import Marionette from 'backbone.marionette'
import UsernameFormView from '../js/views/usernameform'
debug = require('debug')('worker:main')

debug 'Hello there I\'m the main debugger'
app = new Marionette.Application
app.addRegions
  main: '#main-container'

app.on 'start', ->
  chatView = new UsernameFormView()
  app.getRegion('main').show chatView
app.start()
