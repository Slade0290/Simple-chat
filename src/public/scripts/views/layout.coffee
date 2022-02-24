import Marionette from 'backbone.marionette'
import HeaderUserSignupView from 'views/layout/headerusersignup'
import HeaderUserLoggedView from 'views/layout/headeruserlogged'
import Authentication from 'lib/authentication'
import Socket from 'lib/socket'
import Debug from 'debug'
debug = Debug 'chat:views:layout'

export default class LayoutView extends Marionette.View
  template: require 'templates/layout'

  className: 'layoutView'

  regions:
    headerUserNavigation: '#header-user-navigation'
    subcontainer: '#sub-container'

  initialize: ()->
    @showHeaderUserSignup()
    Authentication.on 'login', (user)=>
      @showHeaderUserLogged user

    Authentication.on 'logout', ()=>
      @showHeaderUserSignup()

  showSubview: (childView)->
    @showChildView 'subcontainer', childView

  showHeaderUserSignup: ()->
    @showChildView 'headerUserNavigation', new HeaderUserSignupView

  showHeaderUserLogged: (user)->
    @showChildView 'headerUserNavigation', new HeaderUserLoggedView
      model: new Backbone.Model {currentUser: user}
