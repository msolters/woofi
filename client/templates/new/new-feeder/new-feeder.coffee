###
#     Template.newFeeder
###
Template.newFeeder.events
  'click button#cancel': (event, template) ->
    AntiModals.dismissOverlay template.firstNode
  'submit form#new-feeder': (event, template) ->
    _feeder =
      name: template.find('input#new-feeder-name').value
      sn: template.find('input#new-feeder-sn').value.toLowerCase()
    Meteor.call 'createFeeder', _feeder, (err, resp) ->
      handleMethodResponse err, resp
      AntiModals.dismissOverlay template.firstNode if resp.success
    return false
