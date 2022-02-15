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
  # put the chat message part in login or signup
  # maybe don't let the user login after he signup so that he has to signup and then login to be able to use the chat
  # this be like :
  # signup
  # then
  # login
    # send that user X is connected admin info
    # handle chat part
  socket.on 'send:chat:message', (msg, date)->
    console.log userdb
    io.emit 'emit:chat:message', userdb.email, msg, date

  socket.on 'set:username', ()->
    io.emit 'admin:info:connected', userdb.email
    socket.on 'disconnect', () ->
      io.emit 'admin:info:disconnected', userdb.email
      # make every call async
  socket.on 'login', (email, password, callback)->
    userdb = await database.getUser(email)
    console.log userdb
    if userdb and bcrypt.compareSync(password, userdb.password)
      callback null
      # if ok add session information on server and in the cookie
      # use socket instead of session
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
