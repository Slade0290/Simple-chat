Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:login')
bcrypt = require('bcryptjs')

export default class LoginView extends Marionette.View
  template: require 'templates/login'

  className: 'loginView formView'

  ui:
    email: '#email'
    password: '#password'
    button: '#button'

  events:
    'submit form': 'connectToAccount'

  connectToAccount: ()->
    console.log(@ui.email)
    console.log(@ui.password)
    console.log(@ui.button)
    salt = bcrypt.genSaltSync 10
    hash = bcrypt.hashSync @ui.password.val(), salt
    # Get email & password from db
    emaildb = "test"
    passworddb = "test"
    if bcrypt.compareSync(passworddb, hash) && @ui.email.val() is emaildb
      console.log 'change page'
      # if ok add session information on server and in the cookie and change page to chat
    else
      console.log 'err wrong email or password'
    return false
