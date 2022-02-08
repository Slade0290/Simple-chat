Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:profil')

export default class ProfilView extends Marionette.CollectionView
  template: require 'templates/profil'

  className: 'profilView'
