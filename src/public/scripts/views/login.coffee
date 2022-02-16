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
    'submit form': 'submitLoginCredential'

  submitLoginCredential: ()->
    @trigger 'socket:emit', 'login', @ui.email.val(), @ui.password.val(), @connectToAccount
    return false

  connectToAccount: (err)=>
    if !err
      @trigger 'socket:emit', 'user:connected'
      window.location.hash = "#chat"
    else
    console.log 'show err', err
