import Marionette from 'backbone.marionette'
import Authentication from 'lib/authentication'
import Socket from 'lib/socket'
import Debug from 'debug'
debug = Debug 'chat:views:profile'

export default class ProfileView extends Marionette.View
  template: require 'templates/profile'

  className: 'profileView'

  ui:
    avatar: '#avatar'
    username: '#username'
    usernameInput: '#usernameInput'
    buttonEditUsername: '#buttonEditUsername'
    buttonCheckUsername: '#buttonCheck'
    buttonEditAvatar: "#buttonEditAvatar"
    fileInput: '#fileInput'

  events:
    'click #buttonEditUsername' : 'editUsername'
    'click #buttonCheckUsername' : 'checkUsername'
    'click #buttonEditAvatar' : 'editAvatar'

  editAvatar: ->
    fileInput.addEventListener 'change', @handleFile
    fileInput.click()

  handleFile: ->
    file = @files[0]
    fileReader = new FileReader
    fileReader.onload = ()=>
      avatar.src = fileReader.result
      Authentication.updateUserAvatar fileReader.result
    fileReader.readAsDataURL file

  editUsername: ->
    @hideAndShowUI [{el :usernameInput, action: 'show'}, {el: username, action: 'hide'}, {el: buttonEditUsername, action: 'hide'}, {el: buttonCheckUsername, action: 'show'}]

  checkUsername: ->
    newUsername = @ui.usernameInput.val()
    if newUsername
      res = Authentication.updateUsername(newUsername)
      if res
        @hideAndShowUI [{el :usernameInput, action: 'hide'}, {el: username, action: 'show'}, {el: buttonEditUsername, action: 'show'}, {el: buttonCheckUsername, action: 'hide'}]
        @ui.username[0].innerText = @ui.usernameInput.val()
        @ui.usernameInput.val('')
      else
        console.error 'Error during username update:', res
    else
      debug 'username must contains at least one character'

  hideAndShowUI: (arr)->
    for obj in arr
      if obj.action is 'hide'
        obj.el.style.display = 'none'
      else
        obj.el.style.display = 'inline'
