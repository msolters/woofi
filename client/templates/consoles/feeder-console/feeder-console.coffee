###
#     Template.feederConsole
###
Template.feederConsole.created = ->
  @autorun =>
    feeder_q =
      sn: FlowRouter.getParam 'sn'
    if !Feeders.findOne feeder_q
      FlowRouter.redirect '/'


###
#     Tempate.deleteFeeder
###
Template.deleteFeeder.events
  'click button#cancel': (event, template) ->
    AntiModals.dismissOverlay template.firstNode
  'click button#delete-feeder': (event, template) ->
    Meteor.call "deleteFeeder", template.data.feeder.sn, (err, resp) ->
      handleMethodResponse err, resp
      if resp.success
        AntiModals.dismissOverlay template.firstNode
        FlowRouter.redirect '/'
