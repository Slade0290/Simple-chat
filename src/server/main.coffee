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

  socket.on 'login', (email, password, callback)->
    console.log 'in socket on login server:', email, password, callback
    currentUser = await database.getUser(email)
    if currentUser and bcrypt.compareSync(password, currentUser.password)
      callback null, currentUser
      console.log 'ok after callback'
    else
      callback null, false
      console.log 'nok after callback'

  socket.on 'logout', (callback) ->
    if currentUser?
      currentUser = null
    callback null, currentUser

  socket.on 'send:chat:message', (msg, date)->
    if currentUser
      io.emit 'emit:chat:message', currentUser.email, msg, date

  socket.on 'test:module', (val1, val2, callback)->
    callback 'I\'m a message from the server'

http.listen 3000, ()->
  console.log "Server running on 3000"
