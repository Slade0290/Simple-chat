Marionette = require 'backbone.marionette'
debug = require('debug')('chat:view:headeruserlogged')

export default class HeaderUserLoggedView extends Marionette.View
  template: require 'templates/headeruserlogged'

  className: 'headerUserLoggedView'

  
