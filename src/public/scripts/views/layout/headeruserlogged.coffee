Marionette = require 'backbone.marionette'
Authentication = require 'lib/authentication'
Socket = require 'lib/socket'
debug = require('debug')('chat:view:headeruserlogged')

export default class HeaderUserLoggedView extends Marionette.View
  template: require 'templates/layout/headeruserlogged'

  className: 'headerUserLoggedView'

  events:
    'click #logout' : 'logout'

  logout: ()->
    result = await Authentication.default.logout() # handle error ?
