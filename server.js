var app = require('express')()
var http = require('http').Server(app)
var io = require('socket.io')(http)
var path = require('path')

app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname, 'index.html')) // REPLACE
})

io.on('connection', function(socket) {

  console.log('an user is connected')
  socket.on('disconnect', function() {
    console.log('an user is disconnect')
  })

  socket.on('chat message', function(msg) {
    console.log('message reçu :', msg)
    io.emit('chat message', msg)
  })
})

http.listen(3000, function(){
  console.log("Server running on 3000")
})
