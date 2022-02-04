Marionette = require 'backbone.marionette'
debug = require('debug')('chat:views:chat')
import moment from 'moment'
import io from 'socket.io-client'
socket = io()

class ChatMessageItem extends Marionette.ItemView
  template: require 'templates/chatmessageitem'

  className: "message-item"

export default class ChatView extends Marionette.CompositeView
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
    self = this
    socket.on 'emit:chat:message', (username, msg, date)->
      self.showMsg username, msg, date

    socket.on 'admin:info:connected', (username)->
      self.showMsg "Admin", "Please welcome #{username}", moment().format('MMMM Do YYYY, h:mm:ss a')

    socket.on 'admin:info:disconnected', (username)->
      self.showMsg "Admin", "Say goodbye to #{username}", moment().format('MMMM Do YYYY, h:mm:ss a')

  sendChatMessage: ()->
    try
      textMsg = @ui.inputtext.val()
      username = @options.username
      if(textMsg isnt '')
        date = moment().format('MMMM Do YYYY, h:mm:ss a')
        socket.emit('send:chat:message', username, textMsg, date)
        console.log 'End sendChatMessage'
    catch e
      console.log 'in catch error'
      console.error e
    return false

  showMsg: (_username, _textMsg, _date)->
    console.log 'Show msg'
    @collection.add({
      username: _username,
      text: _textMsg,
      date: _date
    })
    @ui.messagescontainer[0].scrollTop = @ui.messagescontainer[0].scrollHeight - @ui.messagescontainer[0].clientHeight
    @ui.inputtext.val ''
    console.log 'End - Show msg'
