Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:chat')
import moment from 'moment'

class ChatMessageItem extends Marionette.View
  template: require 'templates/chatmessageitem'

  className: "message-item"

export default class ChatView extends Marionette.CollectionView
  template: require 'templates/chat'

  className: 'chatView'

  childView: ChatMessageItem
  childViewContainer: '#messages'

  ui:
    messagescontainer: '#msg-container'
    messages: '#messages'
    inputtext: '#text-message'
    buttonsendmessage: '#btn-send'

  events:
    'submit form': 'sendChatMessage'

  initialize: ()->
    @options.socket.on 'emit:chat:message', (username, message, date)=>
      @showMessage username, message

    @options.socket.on 'admin:info:connected', (username)=>
      @showMessage "Admin", "Please welcome #{username}"

    @options.socket.on 'admin:info:disconnected', (username)=>
      @showMessage "Admin", "Say goodbye to #{username}"

  sendChatMessage: ()->
    try
      textMessage = @ui.inputtext.val()
      @ui.inputtext.val('')
      if textMessage
        @trigger 'socket:emit', 'send:chat:message', textMessage
    catch e
      console.error e
    return false

  showMessage: (_username, _textMessage)->
    unless @isRendered()
      await new Promise (resolve)=>
        @on 'render', resolve
    @collection.add({
      username: _username,
      text: _textMessage,
      date: moment().format('MMMM Do YYYY, h:mm:ss a')
    })
