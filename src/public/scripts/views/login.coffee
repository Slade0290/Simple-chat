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

  submitLoginCredential: (event)->
    debug 'in submitLoginCredential'
    event.preventDefault()
    await Authentication.login @ui.email.val(), @ui.password.val()
    return false
