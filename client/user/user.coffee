###
#       Template.user
###
Template.user.rendered = ->
  $("ul#user-tabs").tabs()


###
#     Template.userProfile
###
Template.userProfile.events
  'keydown input#user-name': (event, template) ->
    clearTimeout template.name if template.name?
    return unless isInput event.which
    template.name = setTimeout =>
      new_name = event.target.value
      return if new_name.length is 0
      _user =
        "profile.name": new_name
      Meteor.call "updateUser", _user, (e, r) -> handleMethodReply e, r
    , 800
  'focusout input#user-name': (event, template) ->
    if event.target.value.length is 0
      defaultName = "Anonymous"
      event.target.value = defaultName
      _user =
        "profile.name": defaultName
      Meteor.call "updateUser", _user
      Materialize.toast "Please provide your name!", 4000
  'keydown input#user-email': (event, template) ->
    clearTimeout template.email if template.email?
    return unless isInput event.which
    template.email = setTimeout =>
      new_email = event.target.value
      return if new_email.length is 0
      return unless validateEmail.test new_email
      _user =
        "emails.0.address": new_email
      Meteor.call "updateUser", _user, (e, r) -> handleMethodReply e, r
    , 800
  'focusout input#user-email': (event, template) ->
    if event.target.value.length is 0
      event.target.value = Meteor.user().emails[0].address
  'keydown input#user-phone': (event, template) ->
    clearTimeout template.phone if template.phone?
    return unless isInput event.which
    template.phone = setTimeout =>
      new_phone = event.target.value
      _user =
        "profile.phone": new_phone
      Meteor.call "updateUser", _user, (e, r) -> handleMethodReply e, r
    , 800
  'keydown textarea#user-address': (event, template) ->
    clearTimeout template.address if template.address?
    return unless isInput event.which
    template.address = setTimeout =>
      new_address = event.target.value
      _user =
        "profile.address": new_address
      Meteor.call "updateUser", _user, (e, r) -> handleMethodReply e, r
    , 800
