###
#     Template.login
###
Template.login.rendered = ->
  $("input#login-email").focus()

Template.login.events
  'submit form#turnkey-login': (event, template) ->
    _user =
      user: template.find("#login-email").value
      password: template.find("#login-password").value
    Meteor.loginWithPassword _user.user, _user.password, (e, r) ->
      if e?
        Materialize.toast "Sorry, we couldn't log you in with that information.  Why don't you give it another shot?", 4000, "red"
      else
        Materialize.toast "Welcome back, #{Meteor.user().profile.name.split(' ')[0]}!", 4000
    return false


###
#     Template.register
###
Template.register.rendered = ->
  $("input#register-name").focus()

Template.register.events
  'submit form#turnkey-register': (event, template) ->
    _user =
      name: template.find("#register-name").value
      email: template.find("#register-email").value
      password: template.find("#register-password").value
      password_confirm: template.find("#register-password-confirm").value
    Meteor.call "createNewUser", _user, (e, r) ->
      handleMethodReply e, r
      if r.success
        Meteor.loginWithPassword _user.email, _user.password, (e, r) ->
          if e?
            Materialize.toast e, 4000, "red"
          else
            Router.go "/"
    return false
