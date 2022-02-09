Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:login')

export default class LoginView extends Marionette.View
  template: require 'templates/login'

  className: 'loginView'
