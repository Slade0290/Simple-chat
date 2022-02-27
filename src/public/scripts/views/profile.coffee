import Marionette from 'backbone.marionette'
import Authentication from 'lib/authentication'
import Socket from 'lib/socket'
import Debug from 'debug'
debug = Debug 'chat:views:profile'

export default class ProfileView extends Marionette.View
  template: require 'templates/profile'

  className: 'profileView'

  ui:
    username: '#username'
    usernameInput: '#usernameInput'
    buttonEdit: '#buttonEdit'
    buttonCheck: '#buttonCheck'

  events:
    'click #buttonEdit' : 'editUsername'
    'click #buttonCheck' : 'checkUsername'

  editUsername: ->
    @hideAndShowUI [{el :usernameInput, action: 'show'}, {el: username, action: 'hide'}, {el: buttonEdit, action: 'hide'}, {el: buttonCheck, action: 'show'}]

  checkUsername: ->
    newUsername = @ui.usernameInput.val()
    if newUsername
      res = await Socket.emit 'update:username', newUsername
      if res
        Authentication.updateUser(newUsername)
        @hideAndShowUI [{el :usernameInput, action: 'hide'}, {el: username, action: 'show'}, {el: buttonEdit, action: 'show'}, {el: buttonCheck, action: 'hide'}]
        @ui.username[0].innerText = @ui.usernameInput.val()
        @ui.usernameInput.val('')
      else
        console.error 'Error during username update:', res
    else
      debug 'in else checkUsername'

  hideAndShowUI: (arr)->
    for obj in arr
      if obj.action is 'hide'
        obj.el.style.display = 'none'
      else
        obj.el.style.display = 'inline'
