###
#     Template.controls
###
Template.controls.events
  'click a[data-wifi-setup]': ->
    AntiModals.overlay 'WiFiSetup'
  'click a[data-delete-feeder]': (event, template) ->
    feeder_q =
      sn: FlowRouter.getParam 'sn'
    feeder = Feeders.findOne feeder_q
    AntiModals.overlay 'deleteFeeder',
      data:
        feeder: feeder
