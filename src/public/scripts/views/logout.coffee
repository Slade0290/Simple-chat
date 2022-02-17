Marionette = require 'backbone.marionette'
debug = require('debug')('chat:view:logout')

export default class LogoutView extends Marionette.View
  template: require 'templates/logout'

  className: 'logoutView'
