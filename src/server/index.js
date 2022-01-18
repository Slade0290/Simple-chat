var express = require('express')
var app = express()
var http = require('http').Server(app)
var io = require('socket.io')(http)
var path = require('path')

app.use(express.static(path.join(__dirname,'../public')))

io.on('connection', function(socket) {
  console.log('a user is connected')

  socket.on('chat message', function(username, msg, date) {
    console.log('message reçu :', msg)
    console.log('auteur du message :', username)
    io.emit('chat message', username, msg, date)
  })

  socket.on('admin info connected', function(username) {
    io.emit('admin info connected', username, "Please welcome ")
    socket.on('disconnect', function() {
      io.emit('admin info disconnected', username, "Say goodbye to ")
      console.log('a user is disconnect')
    })
  })
})

http.listen(3000, function(){
  console.log("Server running on 3000")
})
