Marionette = require 'backbone.marionette'
debug = require('debug')('chat:view:headerusersignup')

export default class HeaderUserSignupView extends Marionette.View
  template: require 'templates/headerusersignup'

  className: 'headerUserSignupView'
