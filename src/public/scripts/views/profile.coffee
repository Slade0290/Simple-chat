import Marionette from 'backbone.marionette'
import Debug from 'debug'
debug = Debug 'chat:views:profile'

export default class ProfileView extends Marionette.View
  template: require 'templates/profile'

  className: 'profileView'
