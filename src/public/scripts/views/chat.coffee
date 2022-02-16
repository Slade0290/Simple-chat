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
    debug 'In initialize chatView'
    @options.socket.on 'emit:chat:message', (username, msg, date)=>
      @showMsg username, msg, date

    @options.socket.on 'admin:info:connected', (username)=>
      @showMsg "Admin", "Please welcome #{username}", moment().format('MMMM Do YYYY, h:mm:ss a')

    @options.socket.on 'admin:info:disconnected', (username)=>
      @showMsg "Admin", "Say goodbye to #{username}", moment().format('MMMM Do YYYY, h:mm:ss a')

  sendChatMessage: ()->
    try
      textMsg = @ui.inputtext.val()
      console.log 'in sendChatMessage', @ui.inputtext.val()
      username = @options.username
      if textMsg
        date = moment().format('MMMM Do YYYY, h:mm:ss a')
        @options.socket.emit('send:chat:message', textMsg, date)
        console.log 'End sendChatMessage'
    catch e
      console.error e
    return false

  showMsg: (_username, _textMsg, _date)=>
    console.log 'Show msg', _username, _textMsg, _date
    @collection.add({
      username: _username,
      text: _textMsg,
      date: _date
    })
    @ui.inputtext.val('')
    console.log 'End - Show msg'
