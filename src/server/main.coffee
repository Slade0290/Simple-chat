express = require 'express'
app = express()
http = require('http').Server app
io = require('socket.io') http
path = require 'path'
bcrypt = require 'bcrypt'
debug = require('debug')('chat:server')
database = require './database'
helpers = require './helpers'

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

  socket.on 'update:username', (newUsername, callback)->
    result = await database.getUser(newUsername)
    if !result
      await database.updateUsername(currentUser.username, newUsername)
      callback null, true
    else
      callback 'username already used', false

  socket.on 'update:avatar', (username, avatar, callback)->
    result = await database.getUser(username)
    if result
      fileSavePath = "src/public/img/users/avatar-#{result.id}.jpg"
      helpers.base64ToImageFile(avatar, fileSavePath)
      fileFetchPath = "img/users/avatar-#{result.id}.jpg"
      res = await database.updateUserAvatar(username, fileFetchPath)
      callback null, res
    else
      callback 'username not found', false

  socket.on 'get:user', (username, callback)->
    res = await database.getUser(username)
    if res
      callback null, res
    else
      callback null, false

http.listen 3000, ()->
  console.log "Server running on 3000"
