Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:profile')

export default class ProfileView extends Marionette.View
  template: require 'templates/profile'

  className: 'profileView'
