var Marionette = require('backbone.marionette')
var debug = require('debug')('worker:chat')

var ChatMessageItem = Marionette.ItemView.extend({
  initialize: function() {
    console.log("initializing chatmessageitem",this.options);
    debug("test - 0");
  },

  template: require('../templates/chatmessageitem.handlebars'),

  className: function() {
    // also add ${side}-date date-msg
    console.log(arguments);
    if(true) {
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
  template: require('../templates/chat.handlebars'),

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
      this.collection.add({
        // name: // Get le username from quelque part
        text: this.ui.inputtext.val()
      })
    } catch(e) {
      console.error(e);
    }
    return false
  },

  messageSent: function() {
    this.ui.inputtext.val('')
  }

})

module.exports = ChatView
