import Marionette from 'backbone.marionette'
import Authentication from 'lib/authentication'
import Debug from 'debug'
debug = Debug 'chat:views:signup'

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
      event.preventDefault()
      await Authentication.signup @ui.email.val(), @ui.password1.val()
    else
      debug 'password mismatch'
      # show fail message
