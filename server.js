var express = require('express')
var app = express()
var http = require('http').Server(app)
var io = require('socket.io')(http)
var path = require('path')

app.use(express.static('public'))

io.on('connection', function(socket) {

  console.log('an user is connected')
  socket.on('disconnect', function() {
    console.log('an user is disconnect')
  })

  socket.on('chat message', function(author, msg) {
    console.log('message reçu :', msg)
    console.log('auteur du message :', author)
    io.emit('chat message', author, msg)
  })
})

http.listen(3000, function(){
  console.log("Server running on 3000")
})
