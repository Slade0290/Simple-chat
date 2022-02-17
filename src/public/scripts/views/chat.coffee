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
      @showMsg username, msg

    @options.socket.on 'admin:info:connected', (username)=>
      @showMsg "Admin", "Please welcome #{username}"

    @options.socket.on 'admin:info:disconnected', (username)=>
      @showMsg "Admin", "Say goodbye to #{username}"

  onRender: ->
    debug 'view rendered'

  sendChatMessage: ()->
    try
      console.log 'in sendChatMessage', @ui.inputtext.val()
      textMsg = @ui.inputtext.val()
      @ui.inputtext.val('')
      if textMsg
        @trigger 'socket:emit', 'send:chat:message', textMsg
    catch e
      console.error e
    return false

  showMsg: (_username, _textMsg)->
    debug 'in showMsg', @ui.inputtext
    unless @isRendered()
      await new Promise (resolve)=>
        @on 'render', resolve
    @collection.add({
      username: _username,
      text: _textMsg,
      date: moment().format('MMMM Do YYYY, h:mm:ss a')
    })
