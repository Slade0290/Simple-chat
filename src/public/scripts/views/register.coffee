Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:register')

export default class RegisterView extends Marionette.View
  template: require 'templates/register'

  className: 'registerView mainView'

  ui:
    username: '#username'
    password1: '#password1'
    password2: '#password2'
    button: '#button'

  events:
    'submit form': 'createAccount'

  initialize: ()->
    console.log 'initialize register'

  createAccount: ()->
    console.log '@ui.username', @ui.username
    console.log '@ui.password1', @ui.password1
    console.log '@ui.password2', @ui.password2
    console.log '@ui.button', @ui.button
    return false
    # TODO:
    # check if username exist else err
    # check if password1 === password2 else err
    # Hash password with salt
    # Send username and password hashed to db
    # if ok add session information on server and in the cookie and change page to chat
