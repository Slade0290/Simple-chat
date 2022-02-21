Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:chat')
Socket = require 'lib/socket'
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
    Socket.default.on 'emit:chat:message', (username, message, date)=>
      @showMessage username, message

    Socket.default.on 'user:logged', (username)=>
      @showMessage "Admin", "Please welcome #{username}"

    Socket.default.on 'admin:info:logout', (username)=>
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
