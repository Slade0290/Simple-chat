express = require 'express'
app = express()
http = require('http').Server app
io = require('socket.io') http
path = require 'path'
username = ""

app.use(express.static(path.join(__dirname,'../public')))

io.on 'connection', (socket)->
  console.log 'main.coffee - on connection'

  socket.on 'send:chat:message', (username, msg, date)->
    console.log 'before emit'
    io.emit 'emit:chat:message', username, msg, date
    console.log 'after emit'

  socket.on 'set:username', (username) ->
    io.emit 'admin:info:connected', username
    socket.on 'disconnect', () ->
      io.emit 'admin:info:disconnected', username

http.listen 3000, ()->
  console.log "Server running on 3000"
