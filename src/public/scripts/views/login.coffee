Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:login')

export default class LoginView extends Marionette.View
  template: require 'templates/login'

  className: 'loginView mainView'

  ui:
    username: '#username'
    password: '#password'
    button: '#button'

  events:
    'submit form': 'connectToAccount'

  connectToAccount: ()->
    console.log(@ui.username)
    console.log(@ui.password)
    console.log(@ui.button)
    return false
    # TODO:
    # Hash password with salt
    # Send username and password hashed to db and check if user exist and if password hash is ok
    # if ok add session information on server and in the cookie and change page to chat
    # if nok show red message 'wrong username or password and do nothing'
