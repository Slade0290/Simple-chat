var Marionette = require('backbone.marionette')

var ChatMessageItem = Marionette.LayoutView.extend({
  template: require('./templates/chatmessageitem'),

  className: function(side) {
    // also add ${side}-date date-msg
    if(side) {
      return "right"
    }
    return "left"
  }
  // EXAMPLE
  // this.listenTo(this.model, 'change:name', function (name) {
  //         if (name === 'hi') {
  //            this.$el.addClass('hi');
  //         } else if......
  // });
})

var ChatView = Marionette.CollectionView.extend({
  template: require('./templates/chat'),
  childView: ChatMessageItem,
  childViewContainer: '#messages',

  ui: {
    messages: '#messages',
    inputtext: '#text-message',
    buttonsendmessage: '#btn-send'
  },

  triggers: {
    'submit @ui.inputtext': 'send:chat:message'
  },

  collectionEvents: {
    add: 'messageSent'
  },

  onSendChatMessage: function() {
    // Get message from input and send it
    this.collection.add({
      // C'est flou la
      // La collection view a une collection
      // on ajoute l'item à la collection
      // name: // Get le nickname from quelque part
      text: this.ui.inputtext.val()
    })
  },

  messageSent: function() {
    this.ui.inputmessage.val('')
  }

})

module.exports = ChatView
