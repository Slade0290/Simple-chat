import Marionette from 'backbone.marionette'
import Debug from 'debug'
debug = Debug 'chat:views:headerusersignup'

export default class HeaderUserSignupView extends Marionette.View
  template: require 'templates/layout/headerusersignup'

  className: 'headerUserSignupView'
