Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:signup')
bcrypt = require('bcryptjs')

export default class SignupView extends Marionette.View
  template: require 'templates/signup'

  className: 'signupView formView'

  ui:
    email: '#email'
    password1: '#password1'
    password2: '#password2'
    button: '#button'

  events:
    'submit form': 'createAccount'

  initialize: (@app)->
    console.log 'initialize signup'

  createAccount: ()->
    console.log 'in createAccount'
    if @ui.password1.val() is @ui.password2.val()
      res = @app.socket.emit 'signup', @ui.email.val(), @ui.password1.val()
      console.log 'res', res
    else
      console.log 'password mismatch'
    return false
