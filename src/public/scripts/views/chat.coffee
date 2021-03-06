import Marionette from 'backbone.marionette'
import Socket from 'lib/socket'
import Authentication from 'lib/authentication'
import moment from 'moment'
import Debug from 'debug'
debug = Debug 'chat:views:chat'

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
    Socket.on 'emit:chat:message', (username, message, date)=>
      @showMessage username, message

    Authentication.on 'login', (user)=>
      @showMessage "Admin", "Please welcome #{user.username}"

    Authentication.on 'logout', (user)=>
      @showMessage "Admin", "Say goodbye to #{user.username}"

  sendChatMessage: ()->
    try
      textMessage = @ui.inputtext.val()
      @ui.inputtext.val('')
      if textMessage
        @trigger 'socket:emit', 'send:chat:message', textMessage
    catch e
      console.error e
    return false

  showMessage: (username, textMessage)->
    unless @isRendered()
      await new Promise (resolve)=>
        @on 'render', resolve
    @collection.add({
      username: username,
      text: textMessage,
      date: moment().format('MMMM Do YYYY, h:mm:ss a')
    })
