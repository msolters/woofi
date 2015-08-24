###
#     Template.internalSideNav
###
Template.internalSideNav.created = ->
  @subscribe "Feeders"

Template.internalSideNav.rendered = ->
  @sideNavTrigger = $ @find '.button-collapse'
    .sideNav()

Template.internalSideNav.helpers
  feeders: ->
    Feeders.find().fetch()

Template.internalSideNav.events
  'click a[data-sign-out]': ->
    AccountsTemplates.logout()
