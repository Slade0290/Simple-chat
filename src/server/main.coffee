express = require 'express'
app = express()
http = require('http').Server app
io = require('socket.io') http
path = require 'path'
bcrypt = require 'bcrypt'
debug = require('debug')('chat:server')
database = require './database'

app.use(express.static(path.join(__dirname,'../public')))

io.on 'connection', (socket)->
  currentUser = null

  # SIGNUP
  socket.on 'signup', (email, password, callback)->
    currentUser = await database.getUser(email)
    if !currentUser
      salt = bcrypt.genSaltSync 10
      hash = bcrypt.hashSync password, salt
      createUserRes = await database.createUser(email, hash)
      # if ok add session information on server and in the cookie and change page to chat
      callback()
    else
      callback 'email already used'

  # LOGIN
  socket.on 'login', (email, password, callback)->
    currentUser = await database.getUser(email)
    if currentUser and bcrypt.compareSync(password, currentUser.password)
      callback()
      # ADMIN INFO
      io.emit 'admin:info:connected', currentUser.email
      socket.on 'disconnect', () ->
        io.emit 'admin:info:disconnected', currentUser.email
      # if ok add session information on server and in the cookie
      # use socket instead of session
    else
      callback 'wrong email or password'

  # CHAT
  socket.on 'send:chat:message', (msg, date)->
    if currentUser
      io.emit 'emit:chat:message', currentUser.email, msg, date

http.listen 3000, ()->
  console.log "Server running on 3000"
