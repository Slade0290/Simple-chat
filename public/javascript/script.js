
// TODO :
// diff between out and in msg
// show when someone connect or disconnect

// Global const
const socket = io()
const messageInput = document.getElementById("text-message")
const btnSend = document.getElementById("btn-send")
const msgContainer = document.getElementById('msg-container')
const messages = document.getElementById('messages')
let author = "User0"

// Handle messages
function submitMsg() {
  if(messageInput.value !== '') {
    socket.emit('chat message', author, messageInput.value)
    messageInput.value = ""
  }
}

function handleIncomingMsg(auhor,msg) {
  var div = document.createElement('div')
  div.classList.add("message-item")
  div.classList.add("right-side")
  div.innerText = msg
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

// Socket
socket.on('chat message', handleIncomingMsg)
