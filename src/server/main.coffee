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
  database.createTable()
  socket.on 'signup', (username, password, signupDate, callback)->
    currentUser = await database.getUser(username)
    if !currentUser
      hash = bcrypt.hashSync password, 10
      createUserRes = await database.createUser(username, hash, signupDate)
      callback null, true
    else
      callback 'username already used', false

  socket.on 'login', (username, password, callback)->
    currentUser = await database.getUser(username)
    if currentUser and bcrypt.compareSync(password, currentUser.password)
      callback null, currentUser
    else
      callback null, false

  socket.on 'logout', (callback) ->
    if currentUser?
      currentUser = null
      callback null, true
    else
      callback null, false

  socket.on 'send:chat:message', (msg, date)->
    if currentUser
      io.emit 'emit:chat:message', currentUser.username, msg, date

http.listen 3000, ()->
  console.log "Server running on 3000"
