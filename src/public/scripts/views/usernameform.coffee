Marionette = require 'backbone.marionette'
io = require 'socket.io-client'
socket = io()

class UsernameFormView extends Marionette.ItemView
  template: require 'templates/usernameform'

  className: 'username-form-view'

  ui:
    usernameinput: '#usernameInput'

  events:
    'submit form': 'handleSubmit'

  handleSubmit: ()->
    username = @ui.usernameinput.val()
    @trigger 'username:selected', username
    console.log 'username form view before set username'
    socket.emit 'set:username', username
    console.log 'username form view after set username'
    return false

module.exports = UsernameFormView
