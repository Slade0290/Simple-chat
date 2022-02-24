import Debug from 'debug'
debug = Debug 'chat:lib:socket'
import io from 'socket.io-client'
socket = io()

export default Socket =

  on: (message, callback)->
    socket.on message, callback

  emit: (message, args...)->
    return new Promise((resolve, reject)->
      socket.emit(message, args..., (error, response)->
        if error
          console.error error
          reject error
        else
          resolve(response)
      )
    )
