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

  socket.on 'signup', (email, password, signupDate, callback)->
    currentUser = await database.getUser(email)
    if !currentUser
      hash = bcrypt.hashSync password, 10
      createUserRes = await database.createUser(email, hash, signupDate)
      callback null, true
    else
      callback 'email already used', false

  socket.on 'login', (email, password, callback)->
    currentUser = await database.getUser(email)
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
      io.emit 'emit:chat:message', currentUser.email, msg, date

http.listen 3000, ()->
  console.log "Server running on 3000"
