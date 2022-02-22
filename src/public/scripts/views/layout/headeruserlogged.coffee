Marionette = require 'backbone.marionette'
import Authentication from 'lib/authentication'
Socket = require 'lib/socket'
import Debug from 'debug'
debug = Debug 'chat:views:headeruserlogged'

export default class HeaderUserLoggedView extends Marionette.View
  template: require 'templates/layout/headeruserlogged'

  className: 'headerUserLoggedView'

  events:
    'click #logout' : 'logout'

  logout: ()->
    result = await Authentication.logout() # handle error ?
