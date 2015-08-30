###
#     Template.mainLayout
###
Template.mainLayout.events
  'click a[data-add-new-feeder]': ->
    AntiModals.overlay 'newFeeder'
