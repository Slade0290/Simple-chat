Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:login')

export default class LoginView extends Marionette.View
  template: require 'templates/login'

  className: 'loginView formView'

  ui:
    email: '#email'
    password: '#password'
    button: '#button'

  events:
    'submit form': 'checkAccount'

  initialize: (@app)->
    @app.socket.on 'login:response', (status, msg)=>
      @connectToAccount status, msg

  checkAccount: ()->
    @app.socket.emit 'login', @ui.email.val(), @ui.password.val()

  connectToAccount: (status, msg)->
    console.log 'status, msg', status, msg
