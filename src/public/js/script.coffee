import '../css/style.scss'
import Marionette from 'backbone.marionette'
import ChatView from '../js/views/chat'

app = new Marionette.Application
app.addRegions
  main: '#main-container'

app.on 'start', ->
  chatView = new ChatView({
    collection: new Backbone.Collection()
  })
  app.getRegion('main').show chatView
app.start()
