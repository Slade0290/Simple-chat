import Backbone from 'backbone'
import _ from 'lodash'
import Authentication from 'lib/authentication'
import Debug from 'debug'
debug = Debug 'chat:lib:navigate'

export default Navigate =

  to: (route)->
    Backbone.history.navigate(route,{trigger:true})

  toLogin: ->
    Backbone.history.navigate('',{trigger:true})
