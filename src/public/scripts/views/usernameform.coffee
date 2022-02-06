Marionette = require 'backbone.marionette'

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
    return false

module.exports = UsernameFormView
