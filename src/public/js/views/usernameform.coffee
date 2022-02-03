Marionette = require 'backbone.marionette'

UsernameFormView = Marionette.ItemView.extend
  template: require '../templates/usernameform.handlebars'

  className: 'username-form-view',

  ui:
    usernameinput: '#usernameInput'

  events:
    'submit form': 'handleSubmit',
    'click #submitButton': 'handleSubmit'

  handleSubmit: ()->
    this.trigger 'username:selected', this.ui.usernameinput.val()
    return false

module.exports = UsernameFormView
