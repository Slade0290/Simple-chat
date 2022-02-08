Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:home')

export default class HomeView extends Marionette.CollectionView
  template: require 'templates/home'

  className: 'homeView'
