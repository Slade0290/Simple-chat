express = require 'express'
app = express()
http = require('http').Server app
io = require('socket.io') http
path = require 'path'
username = ""

app.use(express.static(path.join(__dirname,'../public')))

io.on 'connection', (socket) ->

  socket.on 'chat:message', (username, msg, date) ->
    io.emit 'chat:message', username, msg, date

  socket.on 'set:username', (username) ->
    io.emit 'admin:info:connected', username, "Please welcome "
    socket.on 'disconnect', () ->
      io.emit 'admin:info:disconnected', username, "Say goodbye to "

http.listen 3000, () ->
  console.log "Server running on 3000"
