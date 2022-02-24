import Backbone from 'backbone'
import _ from 'lodash'
import Authentication from 'lib/authentication'
import Debug from 'debug'
debug = Debug 'chat:lib:navigate'

export default Navigate =

  to: (route)->
    debug '-------------------------------'
    debug 'in to destination', route
    isLogged = Authentication.isLoggedIn()
    debug 'in to destination isLogged', isLogged
    trigger = false
    if (route is 'chat' or route is 'profile') and !isLogged
      debug 'not authenticated and in chat or profile'
      route = ''
      trigger = true
    else if route is '' and isLogged
      debug 'in else if'
      route = 'chat'
      trigger = true
    debug 'route', route
    Backbone.history.navigate(route,{trigger:trigger})
