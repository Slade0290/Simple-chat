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
    'submit form': 'connectToAccount'

  initialize: (@app)->
    console.log 'initialize'

  connectToAccount: ()->
    console.log 'in connectToAccount'
    res = @app.socket.emit 'login', @ui.email.val(), @ui.password.val()
    console.log 'res', res
    return false
