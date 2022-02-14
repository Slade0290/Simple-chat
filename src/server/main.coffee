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
      # make every call async
  socket.on 'login', (email, password, callback)->
    userdb = await database.getUser(email)
    if userdb and bcrypt.compareSync(password, userdb.password)
      callback null
      # if ok add session information on server and in the cookie
    else
      callback 'wrong email or password'

  socket.on 'signup', (email, password, callback)->
    userdb = await database.getUser(email)
    if userdb is undefined
      salt = bcrypt.genSaltSync 10
      hash = bcrypt.hashSync password, salt
      createUserRes = database.createUser(email, hash)
      # if ok add session information on server and in the cookie and change page to chat
      callback null
    else
      callback 'email already used'

http.listen 3000, ()->
  console.log "Server running on 3000"
