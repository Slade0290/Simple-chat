express = require 'express'
app = express()
http = require('http').Server app
io = require('socket.io') http
path = require 'path'
bcrypt = require 'bcrypt'
debug = require('debug')('chat:server')

app.use(express.static(path.join(__dirname,'../public')))

io.on 'connection', (socket)->
  # console.log 'main.coffee - on connection'

  socket.on 'send:chat:message', (username, msg, date)->
    console.log 'before emit'
    io.emit 'emit:chat:message', username, msg, date
    console.log 'after emit'

  socket.on 'set:username', (username) ->
    io.emit 'admin:info:connected', username
    socket.on 'disconnect', () ->
      io.emit 'admin:info:disconnected', username

  socket.on 'login', (email, password)->
    console.log 'in login'
    # Get email & password from db
    emaildb = "test"
    passworddb = "test"
    if bcrypt.compareSync(password, passworddb) && @ui.email.val() is emaildb
      console.log 'change page'
      # if ok add session information on server and in the cookie and change page to chat
      # check code http to return
      return true
    else
      console.log 'err wrong email or password'
      # check code http to return
      return false

  socket.on 'signup', (email, password)->
    console.log 'in signup'
    # Get email from db
    emaildb = "test"
    if email is emaildb
      console.log 'email already used'
      return false
    # Send username and password hashed to db
    # if ok add session information on server and in the cookie and change page to chat
    salt = bcrypt.genSaltSync 10
    console.log 'salt', salt
    hash = bcrypt.hashSync password, salt
    console.log 'hash', hash
    return true

http.listen 3000, ()->
  console.log "Server running on 3000"
