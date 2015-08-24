###
#     Template.homeControls
###
Template.homeControls.events
  'click a[data-add-new-feeder]': ->
    AntiModals.overlay 'newFeeder'
