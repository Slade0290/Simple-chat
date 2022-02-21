import Marionette from 'backbone.marionette'
Authentication = require 'lib/authentication'
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
    Authentication.login @ui.email.val(), @ui.password.val()
    # don't call connectToAccount and call another method in router to navigate to #chat if ok
    return false

  connectToAccount: (err)=>
    if !err
      window.location.hash = "#chat" # send event to the router
      # @trigger something #chat router etc..
    else
      console.error 'login failed:', err
