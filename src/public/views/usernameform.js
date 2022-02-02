var Marionette = require('backbone.marionette')

var UsernameFormView = Marionette.ItemView.extend({
  template: function() {
    return `<p>Please enter your name</p>
    <form>
      <input type="text" id="usernameInput" autofocus/>
      <button type="button" id="submitButton">Enter</button>
    </form>`
  },

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
