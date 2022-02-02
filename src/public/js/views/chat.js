var Marionette = require('backbone.marionette')
var _ = require('underscore')

var ChatMessageItem = Marionette.ItemView.extend({
  initialize: function() {
    console.log("initializing chatmessageitem",this.options);
  },
  template: _.template('<div class="message-item right-color"><%= text %></div>'),

  className: function(side) {
    console.log("in classname of chat message item");
    // also add ${side}-date date-msg
    if(side) {
      return "chat-message-item right"
    }
    return "chat-message-item left"
  }
  // EXAMPLE
  // this.listenTo(this.model, 'change:name', function (name) {
  //         if (name === 'hi') {
  //            this.$el.addClass('hi');
  //         } else if......
  // });
})

var ChatView = Marionette.CompositeView.extend({
  template: function() {
    console.log("in template chatview")
    return `<div id="msg-container">
      <div id="messages"></div>
    </div>
    <form class="input-area">
      <input type="text" id="text-message"/>
      <button type="button" id="btn-send">Send</button>
    </form>`
  },

  className: 'chatView',

  childView: ChatMessageItem,
  childViewContainer: '#messages',

// Get le trigger username:selected ici and put in a var

  ui: {
    messages: '#messages',
    inputtext: '#text-message',
    buttonsendmessage: '#btn-send'
  },

  events: {
    'submit form': 'sendChatMessage'
  },

  collectionEvents: {
    add: 'messageSent'
  },

  sendChatMessage: function() {
    try {
      console.log('this',this)
      console.log('this.collection',this.collection)
      this.collection.add({
        // name: // Get le username from quelque part
        text: this.ui.inputtext.val()
      })
      console.log('this.collection',this.collection)
    } catch(e) {
      console.error(e);
    }
    return false
  },

  messageSent: function() {
    this.ui.inputtext.val('')
    console.log("this.ui.inputmessage.val('')", this.ui.inputtext.val(''))
    return false
  }

})

module.exports = ChatView
