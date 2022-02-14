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
    @trigger 'submit:login:credential', @ui.email.val(), @ui.password.val(), @connectToAccount
    return false

  connectToAccount: (err)->
    if !err
      window.location.replace "http://127.0.0.1:3000/#chat" # check that
    else
      console.log 'show err', err
