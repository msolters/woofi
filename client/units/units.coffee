###
#      Template.mass
###
Template.mass.helpers
  'convertMass': (M) ->
    return unless M?
    convertMassToPreference M

Template.mass.events
  'click a[data-mass-toggle]': ->
    unitTriggers.mass.changed()
    successMsg = "Mass is now displayed in "
    switch Meteor.user().profile.units.mass.toLowerCase()
      when "kg"
        newUnit = "lb"
        successMsg += "pounds."
      when "lb"
        newUnit = "kg"
        successMsg += "kilograms."
    _user =
      "profile.units.mass": newUnit
    Meteor.call "updateUser", _user, (e, r) ->
      handleMethodReply e, r, {success: successMsg}
