Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:signup')

export default class SignupView extends Marionette.View
  template: require 'templates/signup'

  className: 'signupView formView'

  ui:
    email: '#email'
    password1: '#password1'
    password2: '#password2'
    button: '#button'

  events:
    'submit form': 'submitNewCredential'

  submitNewCredential: ()->
    if @ui.password1.val() is @ui.password2.val()
      @trigger 'submit:new:credential', @ui.email.val(), @ui.password1.val(), @connectToAccount
    else
      console.log 'show password mismatch'
    return false


  connectToAccount: (err)->
    if !err
      window.location.replace "http://127.0.0.1:3000/#chat" # check that
    else
      console.log 'show err', err
