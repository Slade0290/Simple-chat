import Backbone from 'backbone'
import _ from 'lodash'
import Authentication from 'lib/authentication'
import Debug from 'debug'
debug = Debug 'chat:lib:navigate'

export default Navigate =

  to: (route)->
    isLogged = Authentication.isLoggedIn()
    trigger = false
    if (route is 'chat' or route is 'profile' or route is '') and !isLogged
      route = ''
      trigger = true
    else if (route is '' or route is 'chat' or route is 'signup') and isLogged
      route = 'chat'
      trigger = true
    Backbone.history.navigate(route,{trigger:trigger})
