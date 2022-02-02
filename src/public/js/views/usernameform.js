var Marionette = require('backbone.marionette')

var UsernameFormView = Marionette.ItemView.extend({
  template: require('../templates/usernameform.handlebars'),

  className: 'username-form-view',

  ui: {
    usernameinput: '#usernameInput'
  },

  events: {
    'submit form': 'handleSubmit'
  },

  handleSubmit: function() {
    this.trigger('username:selected', this.ui.usernameInput.val())
    return false
  },
})

module.exports = UsernameFormView


// js -> script (folder)
