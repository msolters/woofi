###
#     Template.addPet
###
Template.addPet.helpers
  newPetMass: -> return Session.get "newPetMass"
  newPetType: -> return Session.get "newPetType"

Template.addPet.rendered = ->
  $('select').material_select()
  $("input#add-pet-name").focus()
  Session.set "newPetMass", "0"
  Session.set "newPetType", "dog"

Template.addPet.events
  "change select#add-pet-type": (event, template) ->
    Session.set "newPetType", event.target.value
  "input input#add-pet-mass": (event, template) ->
    Session.set "newPetMass", convertMassToKilos event.target.value
  "submit form#add-pet": (event, template) ->
    _pet =
      name: template.find("#add-pet-name").value
      type: template.find("#add-pet-type").value
      mass: convertMassToKilos template.find("#add-pet-mass").value
      gender: template.find("#add-pet-gender").value
    Meteor.call "createNewPet", _pet, (e, r) ->
      handleMethodReply e, r
      Router.go "/pets/#{r.petID}" if r.success
    return false
