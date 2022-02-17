Marionette = require 'backbone.marionette'
debug = require('debug')('chat:view:main')

export default class MainView extends Marionette.View
  template: require 'templates/main'

  className: 'mainView'

  regions:
    subRegion: '#sub-container'
