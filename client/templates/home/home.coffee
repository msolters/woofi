###
#     Template.newFeeder
###
Template.newFeeder.events
  'click button#cancel': (event, template) ->
    AntiModals.dismissOverlay template.firstNode
  'click button#create-feeder': (event, template) ->
    AntiModals.dismissOverlay template.firstNode
    Meteor.call "createFeeder", {}, (err, resp) ->
      handleMethodResponse err, resp
