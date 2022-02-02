import '../css/style.scss'
import Marionette from 'backbone.marionette'
import UsernameFormView from '../js/views/usernameform'

app = new Marionette.Application
app.addRegions
  main: '#body-hook'

app.on 'start', ->
  formView = new UsernameFormView()
  app.getRegion('main').show formView
app.start()
