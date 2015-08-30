###
#     Template.homeControls
###
Template.homeControls.events
  'click a[data-add-new-feeder]': ->
    AntiModals.overlay 'newFeeder'
  'click a[data-wifi-setup]': ->
    AntiModals.overlay 'WiFiSetup'
