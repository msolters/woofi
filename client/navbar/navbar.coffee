Template.navbarTop.rendered = ->
  $(".button-collapse").sideNav
    edge: "left"
    menuWidth: 320

Template.navbarTop.events
  'click a[data-action-logout]': ->
    Meteor.logout()
