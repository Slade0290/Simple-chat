
# Import
import moment from 'moment'
import io from 'socket.io-client'
import '../css/style.scss'

# Tools
getElementById = (val) ->
  document.querySelector val

createElement = (type) ->
  document.createElement type

# Global var
socket = io()
messageInput = getElementById "#text-message"
btnSend = getElementById "#btn-send"
msgContainer = getElementById '#msg-container'
messages = getElementById '#messages'
modal = getElementById "#modalUsername"
usernameInput = getElementById '#usernameInput'
btnUsername = getElementById '#btn-username'
_username = ""
lastMsgAuthor = ""
showUsername = true;

# Define username
submitUsername = ->
  if usernameInput.value isnt ''
    _username = usernameInput.value
    modal.style.display = "none"
    socket.emit('set:username', _username)
    return

# Handle messages
submitMsg = ->
  if messageInput.value isnt ''
    socket.emit 'chat:message', _username, messageInput.value, moment().format('MMMM Do YYYY, h:mm:ss a')
    messageInput.value = ""
    return

handleIncomingMsg = (username,msg,date) ->
  side = if _username is username then "right" else "left"
  showUsername = lastMsgAuthor isnt username
  lastMsgAuthor = username
  divMsgAndName = createElement 'div'
  divMsgAndName.classList.add "msg-n-username", "#{side}-side"
  divMsg = createElement 'div'
  divMsg.classList.add "message-item", "#{side}-color"
  divMsg.innerText = msg
  divDate = createElement 'div'
  divDate.classList.add "date-msg", "#{side}-date"
  divDate.innerText = date
  if showUsername
    divUsername = createElement 'div'
    divUsername.classList.add "username-label"
    divUsername.innerText = username
    divMsgAndName.appendChild divUsername
  divMsgAndName.appendChild divMsg
  divMsgAndName.appendChild divDate
  messages.appendChild divMsgAndName
  msgContainer.scrollTop = msgContainer.scrollHeight - msgContainer.clientHeight
  return

handleAdminInfo = (username, msg) ->
  div = createElement 'div'
  div.classList.add "admin-info", "message-item"
  div.innerText = "#{msg} #{username} !"
  messages.appendChild div
  msgContainer.scrollTop = msgContainer.scrollHeight - msgContainer.clientHeight
  return

# Event
btnSend.addEventListener "click", submitMsg
messageInput.addEventListener "keyup", (event) ->
  if event.keyCode is 13
    btnSend.click()

btnUsername.addEventListener "click", submitUsername
usernameInput.addEventListener "keyup", (event) ->
  if event.keyCode is 13
    btnUsername.click()

 # Socket
socket.on 'chat:message', handleIncomingMsg
socket.on 'admin:info:connected', handleAdminInfo #, "Please welcome "
socket.on 'admin:info:disconnected', handleAdminInfo #, "Say goodbye to "
