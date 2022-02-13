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
    return false

  connectToAccount: (status, msg)->
    if status is 200
      window.location.replace "http://127.0.0.1:3000/#chat"
    else
      console.log 'status, msg', status, msg
