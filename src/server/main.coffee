express = require 'express'
app = express()
http = require('http').Server app
io = require('socket.io') http
path = require 'path'
bcrypt = require 'bcrypt'
debug = require('debug')('chat:server')
database = require './database'
currentUserModule = require './currentUser'

app.use(express.static(path.join(__dirname,'../public')))

io.on 'connection', (socket)->
  currentUser = null

  # SIGNUP
  socket.on 'signup', (email, password, callback)->
    currentUser = await currentUserModule.get(email)
    if !currentUser
      salt = bcrypt.genSaltSync 10
      hash = bcrypt.hashSync password, salt
      createUserRes = await database.createUser(email, hash)
      callback()
    else
      callback 'email already used'

  # LOGIN
  socket.on 'login', (email, password, callback)->
    currentUser = await currentUserModule.get(email)
    if currentUser and bcrypt.compareSync(password, currentUser.password)
      # ADMIN INFO
      io.emit 'admin:info:connected', currentUser
      socket.on 'disconnected', () ->
        io.emit 'admin:info:disconnected', currentUser.email
      callback()
    else
      callback 'wrong email or password'

  # CHAT
  socket.on 'send:chat:message', (msg, date)->
    if currentUser
      io.emit 'emit:chat:message', currentUser.email, msg, date

http.listen 3000, ()->
  console.log "Server running on 3000"
