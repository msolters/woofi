###
#     Template.navbar (common to Top and Side)
###
Template.navbar.rendered = ->
  $(".button-collapse").sideNav
    edge: "left"
    menuWidth: 320

###
#     Template.sideNav
###
Template.sideNav.events
  'click a[data-action-logout]': ->
    Materialize.toast "Bye #{Meteor.user().profile.name.split(' ')[0]}, see you soon!", 4000
    Meteor.logout()
    Router.go '/'
  "click #slide-out a, click #sidenav-icon": ->
    if $(window).width() < 992
      $(".button-collapse").sideNav 'hide'
  "click #sidenav-icon": ->
    Router.go "/"


###
#     Template.sideNavPets
###
Template.sideNavPets.rendered = ->
  Meteor.subscribe "Pets"

Template.sideNavPets.helpers
  pets: -> Pets.find()
