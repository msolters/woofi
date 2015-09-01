###
#     Template.externalSideNav
###
Template.externalSideNav.rendered = ->
  @sideNavTrigger = $ @find '.button-collapse'
    .sideNav()

Template.externalSideNav.events
  'click .side-nav a': ->
    $('.button-collapse').sideNav 'hide'
