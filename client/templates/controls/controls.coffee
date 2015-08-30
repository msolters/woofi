###
#     Template.homeControls
###
Template.homeControls.events
  'click a[data-add-new-feeder]': ->
    AntiModals.overlay 'newFeeder'
  'click a[data-wifi-setup]': ->
    AntiModals.overlay 'WiFiSetup'


###
#     Template.feederConsoleControls
###
Template.feederConsoleControls.events
  'click a[data-delete-feeder]': (event, template) ->
    feeder_q =
      sn: FlowRouter.getParam 'sn'
    feeder = Feeders.findOne feeder_q
    AntiModals.overlay 'deleteFeeder',
      data:
        feeder: feeder
