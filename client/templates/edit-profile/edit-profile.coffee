###
#     Template.editProfile
###
Template.editProfile.rendered = ->
  $(@find('#edit-profile')).find('input').click()

Template.editProfile.events
  'click button#cancel': (event, template) ->
    AntiModals.dismissOverlay template.firstNode
  'submit form#edit-profile': (event, template) ->
    _user =
      'profile.name': template.find('input#edit-profile-name').value
    Meteor.call 'updateUser', _user, (err, resp) =>
      handleMethodResponse err, resp
      if resp.success
        AntiModals.dismissOverlay template.firstNode
    return false
