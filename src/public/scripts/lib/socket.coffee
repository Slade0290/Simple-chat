debug = require('debug')('chat:lib:socket')
import io from 'socket.io-client'
socket = io()

export onEvent = (message, args...)->
  debug 'in onEvent'

export emitSocket = (message, args...)->
  return new Promise((resolve, reject) =>
    debug 'in emitSocket message:', message
    if !socket
      reject('No socket connection.')
    else
      socket.emit(message, args..., (response) =>
        if response.error
          console.error response.error
          reject response.error
        else
          resolve()
      )
  )
