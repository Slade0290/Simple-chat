import Marionette from 'backbone.marionette'
import Authentication from 'lib/authentication'
import Debug from 'debug'
debug = Debug 'chat:views:login'

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
      result = await Authentication.login @ui.email.val(), @ui.password.val()
      if result
        @connectToAccount() # emit event user login tell router to change view
      else
        console.log 'login fail'
    catch error
      console.error 'Error during authentication:', error
    return false

  connectToAccount: (err)=>
    if err
      console.error 'login failed:', err
