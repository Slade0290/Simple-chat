Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:register')
bcrypt = require('bcryptjs')

export default class RegisterView extends Marionette.View
  template: require 'templates/register'

  className: 'registerView formView'

  ui:
    email: '#email'
    password1: '#password1'
    password2: '#password2'
    button: '#button'

  events:
    'submit form': 'createAccount'

  initialize: ()->
    console.log 'initialize register'

  createAccount: ()->
    console.log '@ui.password1', @ui.password1.val()
    console.log '@ui.password2', @ui.password2.val()
    if @ui.password1.val() is @ui.password2.val()
      console.log '@ui.email', @ui.email
      console.log '@ui.button', @ui.button
      salt = bcrypt.genSaltSync 10
      console.log 'salt', salt
      hash = bcrypt.hashSync @ui.password1.val(), salt
      console.log 'hash', hash
    else
      console.log 'password mismatch'

    # Get email from db
    emaildb = "test"
    if @ui.email.val() is emaildb
      console.log 'email already used'

    # Send username and password hashed to db
    # if ok add session information on server and in the cookie and change page to chat
    return false
