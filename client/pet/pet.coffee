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
  $(@find('select')).material_select()
  Session.set "#{@data.pet._id}Mass", @data.pet.mass

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
    Meteor.call "updatePet", _pet, (e, r) -> handleMethodReply e, r
  "input input#pet-mass": (event, template) ->
    Session.set "#{@pet._id}Mass", convertMassToKilos event.target.value
  'change input#pet-mass': (event, template) ->
    _pet =
      _id: template.data.pet._id
      mass: convertMassToKilos event.target.value
    Meteor.call "updatePet", _pet, (e, r) -> handleMethodReply e, r
