Marionette = require 'backbone.marionette'
debug = require('debug')('chat:view:main')

export default class LayoutView extends Marionette.View
  template: require 'templates/layout'

  className: 'layoutView'

  regions:
    headerUserNavigation: '#header-user-navigation'
    subcontainer: '#sub-container'

  showSubContainerView: (childView)->
    @showChildView('subcontainer', childView)

  showHeaderUserNavigation: (headerView)->
    @showChildView('headerUserNavigation', headerView)
