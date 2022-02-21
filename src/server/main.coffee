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

  socket.on 'signup', (email, password, callback)->
    currentUser = await database.getUser(email)
    if !currentUser
      hash = bcrypt.hashSync password, 10
      createUserRes = await database.createUser(email, hash)
      callback()
    else
      callback 'email already used'

  socket.on 'login', (email, password)->
    console.log 'server:', email, password
    currentUser = await database.getUser(email)
    if currentUser and bcrypt.compareSync(password, currentUser.password)
      io.emit 'admin:info:login', currentUser
    else
      callback 'wrong email or password'

  socket.on 'logout', () ->
    if currentUser?
      io.emit 'admin:info:logout', currentUser.email
      currentUser = null

  socket.on 'send:chat:message', (msg, date)->
    if currentUser
      io.emit 'emit:chat:message', currentUser.email, msg, date

http.listen 3000, ()->
  console.log "Server running on 3000"
