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
  # TODO : make every call async
  userdb = {}

  # SIGNUP
  socket.on 'signup', (email, password, callback)->
    userdb = await database.getUser(email)
    if userdb
      salt = bcrypt.genSaltSync 10
      hash = bcrypt.hashSync password, salt
      createUserRes = database.createUser(email, hash)
      # if ok add session information on server and in the cookie and change page to chat
      callback null
    else
      callback 'email already used'

  # LOGIN
  socket.on 'login', (email, password, callback)->
    userdb = await database.getUser(email)
    console.log userdb
    if userdb and bcrypt.compareSync(password, userdb.password)
      callback null
      # if ok add session information on server and in the cookie
      # use socket instead of session
    else
      callback 'wrong email or password'

  # ADMIN INFO
  socket.on 'user:connected', ()->
    console.log 'in user:connected socket:on'
    io.emit 'admin:info:connected', userdb.email
    socket.on 'user:disconnect', () ->
      io.emit 'admin:info:disconnected', userdb.email

  # CHAT
  socket.on 'send:chat:message', (msg, date)->
    console.log 'in send:chat:message socket:on'
    io.emit 'emit:chat:message', userdb.email, msg, date

http.listen 3000, ()->
  console.log "Server running on 3000"
