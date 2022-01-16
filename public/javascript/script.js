
// Global const
const socket = io()
const messageInput = document.querySelector("#text-message")
const btnSend = document.getElementById("btn-send")
const msgContainer = document.getElementById('msg-container')
const messages = document.getElementById('messages')
const modal = document.getElementById("modalUsername");
const usernameInput = document.getElementById('usernameInput')
const btnUsername = document.getElementById('btn-username')
let _username = ""
let lastMsgAuthor = ""
let showUsername = true;
// Define username
function submitUsername() {
  if(usernameInput.value !== '') {
    _username = usernameInput.value
    modal.style.display = "none"
    socket.emit('admin info connected', _username)
  }
}

// Handle messages
function submitMsg() {
  if(messageInput.value !== '') {
    socket.emit('chat message', _username, messageInput.value, new Date(Date.now()))
    messageInput.value = ""
  }
}

function handleIncomingMsg(username,msg,date) {
  var side = (_username === username) ? "right" : "left"
  showUsername = (lastMsgAuthor === username) ? false : true
  lastMsgAuthor = username
  var divMsgAndName = document.createElement('div')
  divMsgAndName.classList.add("msg-n-username")
  divMsgAndName.classList.add(`${side}-side`)
  var divMsg = document.createElement('div')
  divMsg.classList.add("message-item")
  divMsg.classList.add(`${side}-color`)
  divMsg.innerText = msg
  var divDate = document.createElement('div')
  divDate.classList.add(`${side}-date`)
  divDate.classList.add("date-msg")
  divDate.innerText = date
  if(showUsername) {
    var divUsername = document.createElement('div')
    divUsername.classList.add("username-label")
    divUsername.innerText = username
    divMsgAndName.appendChild(divUsername)
  }
  divMsgAndName.appendChild(divMsg)
  divMsgAndName.appendChild(divDate)
  messages.appendChild(divMsgAndName)
  msgContainer.scrollTop = msgContainer.scrollHeight - msgContainer.clientHeight;
}

function handleAdminInfo(username, msg) {
  var div = document.createElement('div')
  div.classList.add("message-item")
  div.classList.add("admin-info")
  div.innerText = `${msg} ${username} !`
  messages.appendChild(div)
  msgContainer.scrollTop = msgContainer.scrollHeight - msgContainer.clientHeight;
}

// Event
btnSend.addEventListener("click", submitMsg);
messageInput.addEventListener("keyup", function(event) {
  if (event.keyCode === 13) {
    btnSend.click();
  }
});
btnUsername.addEventListener("click", submitUsername);
usernameInput.addEventListener("keyup", function(event) {
  if (event.keyCode === 13) {
    btnUsername.click();
  }
});

// Socket
socket.on('chat message', handleIncomingMsg)
socket.on('admin info connected', handleAdminInfo)
socket.on('admin info disconnected', handleAdminInfo)
