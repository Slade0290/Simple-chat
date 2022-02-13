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
  socket.on 'send:chat:message', (username, msg, date)->
    io.emit 'emit:chat:message', username, msg, date

  socket.on 'set:username', (username) ->
    io.emit 'admin:info:connected', username
    socket.on 'disconnect', () ->
      io.emit 'admin:info:disconnected', username

  socket.on 'login', (email, password)->
    userdb = await database.getUser(email)
    if userdb isnt undefined
      if bcrypt.compareSync(password, userdb.password) && email is userdb.email
        io.emit 'login:response', 200, 'change page'
        # if ok add session information on server and in the cookie and change page to chat
      else
        io.emit 'login:response', 401, 'wrong email or password'
    else
      io.emit 'login:response', 401, 'email doesn\'t exist'

  socket.on 'signup', (email, password)->
    userdb = await database.getUser(email)
    if userdb is undefined
      salt = bcrypt.genSaltSync 10
      hash = bcrypt.hashSync password, salt
      createUserRes = database.createUser(email, hash)
      # if ok add session information on server and in the cookie and change page to chat
      io.emit 'signup:response', 200, 'change page'
    else
      io.emit 'signup:response', 401, 'email already used'

http.listen 3000, ()->
  console.log "Server running on 3000"
