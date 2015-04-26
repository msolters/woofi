###
#     Template.navbar (common to Top and Side)
###
Template.navbar.events
  'click a[data-action-logout]': ->
    Meteor.logout()


###
#     Template.navbarTop (only for links in the top bar)
###
Template.navbarTop.rendered = ->
  $(".button-collapse").sideNav
    edge: "left"
    menuWidth: 220

###
#     Template.navbarSide
###
Template.navbarSide.events
  "click #slide-out a": ->
    if $(window).width() < 992
      $(".button-collapse").sideNav 'hide'
