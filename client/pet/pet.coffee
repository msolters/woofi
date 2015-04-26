###
#     Template.pet
###
Template.pet.rendered = ->
  $("ul#pet-tabs").tabs()


###
#     Template.petProfile
###
Template.petProfile.helpers
  petMass: -> return Session.get "#{@pet._id}Mass"

Template.petProfile.rendered = ->
  $('select').material_select() # activate dropdown
  Session.set "#{@data.pet._id}Mass", @data.pet.mass  # initialize session var storing pet's weight
  $(@find('.modal-trigger')).leanModal() # initialize pet delete confirmation dialog

Template.petProfile.events
  'keydown input#pet-name': (event, template) ->
    clearTimeout template.name if template.name?
    return unless isInput event.which
    template.name = setTimeout =>
      new_name = event.target.value
      return if new_name.length is 0
      _pet =
        _id: template.data.pet._id
        name: new_name
      Meteor.call "updatePet", _pet, (e, r) -> handleMethodReply e, r
    , 800
  'focusout input#pet-name': (event, template) ->
    if event.target.value.length is 0
      defaultName = "Unnamed #{template.data.pet.type}"
      event.target.value = defaultName
      _pet =
        _id: template.data.pet._id
        name: defaultName
      Meteor.call "updatePet", _pet
      Materialize.toast "A pet with no name?  Ha!  I like your style.  You make up your own rules, just like me.", 4000
  'change select#pet-type': (event, template) ->
    _pet =
      _id: template.data.pet._id
      type: event.target.value
    Meteor.call "updatePet", _pet, (e, r) ->
      handleMethodReply e, r
  'change select#pet-gender': (event, template) ->
    _pet =
      _id: template.data.pet._id
      gender: event.target.value
    Meteor.call "updatePet", _pet, (e, r) ->
      handleMethodReply e, r
  'input input#pet-mass': (event, template) ->
    Session.set "#{@pet._id}Mass", convertMassToKilos event.target.value
  'change input#pet-mass': (event, template) ->
    _pet =
      _id: template.data.pet._id
      mass: convertMassToKilos event.target.value
    Meteor.call "updatePet", _pet, (e, r) ->
      handleMethodReply e, r
  'click button#delete-pet': (event, template) ->
    $(template.find("button[data-target=pet-delete-dialog]")).closeModal()
    Meteor.call "deletePet", template.data.pet._id, (e, r) ->
      handleMethodReply e, r
