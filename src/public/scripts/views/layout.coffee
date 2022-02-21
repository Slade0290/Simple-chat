Marionette = require 'backbone.marionette'
import HeaderUserSignupView from 'views/layout/headerusersignup'
import HeaderUserLoggedView from 'views/layout/headeruserlogged'
debug = require('debug')('chat:view:layout')
Socket = require 'lib/socket'

export default class LayoutView extends Marionette.View
  template: require 'templates/layout'

  className: 'layoutView'

  regions:
    headerUserNavigation: '#header-user-navigation'
    subcontainer: '#sub-container'

  initialize: ()->
    @showHeaderUserSignup()
    Socket.default.on('user:logged', (user)=>
      @showHeaderUserLogged(user)
    )
    Socket.default.on('user:logout', ()=>
      @showHeaderUserSignup()
    )

  showSubContainerView: (childView)->
    @showChildView('subcontainer', childView)

  showHeaderUserSignup: ()->
    @showChildView('headerUserNavigation', new HeaderUserSignupView)

  showHeaderUserLogged: (user)->
    @showChildView('headerUserNavigation', new HeaderUserLoggedView
      model: new Backbone.Model({currentUser: user}))
