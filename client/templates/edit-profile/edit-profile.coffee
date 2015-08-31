###
#     Template.editProfile
###
Template.editProfile.rendered = ->
  $(@find('#edit-profile')).find('input').click()

Template.editProfile.events
  'submit form#edit-profile': (event, template) ->

    return false
