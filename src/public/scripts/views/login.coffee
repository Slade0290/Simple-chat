import Marionette from 'backbone.marionette'
import Authentication from 'lib/authentication'
import Debug from 'debug'
debug = Debug 'chat:views:login'

export default class LoginView extends Marionette.View
  template: require 'templates/login'

  className: 'loginView formView'

  ui:
    username: '#username'
    password: '#password'
    button: '#button'

  events:
    'submit form': 'submitLoginCredential'

  submitLoginCredential: (event)->
    event.preventDefault()
    await Authentication.login @ui.username.val(), @ui.password.val()
