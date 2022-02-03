Marionette = require 'backbone.marionette'
debug = require('debug')('worker:chat')

ChatMessageItem = Marionette.ItemView.extend({
  template: require '../templates/chatmessageitem.handlebars'

  className: "chat-message-item right"
})

ChatView = Marionette.CompositeView.extend({
  initialize: ()->
    debug 'test - 0'

  template: require '../templates/chat.handlebars'

  className: 'chatView'

  childView: ChatMessageItem
  childViewContainer: '#messages'

  ui:
    messages: '#messages'
    inputtext: '#text-message'
    buttonsendmessage: '#btn-send'


  events:
    'submit form': 'sendChatMessage',
    'click #btn-send': 'sendChatMessage'

  collectionEvents:
    add: 'messageSent'

  sendChatMessage: ()->
    try
      this.collection.add({
        username: this.options.username,
        text: this.ui.inputtext.val()
      })
    catch e
      console.error e

    return false

  messageSent: ()->
    this.ui.inputtext.val ''

})

module.exports = ChatView
