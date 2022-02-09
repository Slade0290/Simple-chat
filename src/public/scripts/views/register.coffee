Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:register')

export default class RegisterView extends Marionette.View
  template: require 'templates/register'

  className: 'registerView'
