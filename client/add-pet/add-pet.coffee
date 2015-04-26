###
#     Template.addPet
###
Template.addPet.rendered = ->
  $(@find('select')).material_select()

Template.addPet.events
  "submit form#add-pet": (event, template) ->
    _pet =
      name: template.find("#add-pet-name").value
      type: template.find("#add-pet-type").value
    Meteor.call "createNewPet", _pet, (e, r) ->
      handleMethodReply e, r
      Router.go "/pets/#{r.petID}" if r.success
    return false
