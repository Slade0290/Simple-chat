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

  submitLoginCredential: ()-> # handle in authentication
    try
      auth = new Authentication.default
      result = await auth.login @ui.email.val(), @ui.password.val()
      if result
        @connectToAccount() # emit event user login tell router to change view
      else
        console.log 'login fail'
    catch error
      console.error 'Error during authentication:',error
    return false

  connectToAccount: (err)=>
    if err
      console.error 'login failed:', err
