import Marionette from 'backbone.marionette'
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
      @trigger 'socket:emit', 'signup', @ui.email.val(), @ui.password1.val(), @connectToAccount # change that
    else
      console.log 'show password mismatch'
    return false


  connectToAccount: (err)->
    if !err
      window.location.hash = "#chat"
    else
      console.log 'show err', err
