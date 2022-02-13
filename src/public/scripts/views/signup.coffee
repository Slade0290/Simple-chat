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
    'submit form': 'createAccount'

  initialize: (@app)->
    @app.socket.on 'signup:response', (status, msg)=>
      @connectToAccount status, msg

  createAccount: ()->
    if @ui.password1.val() is @ui.password2.val()
      @app.socket.emit 'signup', @ui.email.val(), @ui.password1.val()
    else
      console.log 'password mismatch'
    return false


  connectToAccount: (status, msg)->
    if status is 200
      window.location.replace "http://127.0.0.1:3000/#chat"
    else
      console.log 'status, msg', status, msg
