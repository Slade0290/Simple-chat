import '../css/style.scss'
import Marionette from 'backbone.marionette'
import Backbone from 'backbone'
import UsernameFormView from 'views/usernameform'
import ChatView from 'views/chat'

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
