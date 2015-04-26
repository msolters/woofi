###
#     Template.navbar (common to Top and Side)
###
Template.navbar.rendered = ->
  $(".button-collapse").sideNav
    edge: "left"
    menuWidth: 220

Template.navbar.events
  'click a[data-action-logout]': ->
    Materialize.toast "Bye #{Meteor.user().profile.name.split(' ')[0]}, see you soon!", 4000
    Meteor.logout()


###
#     Template.sideNav
###
Template.sideNav.helpers
  urlIs: (_url) ->
    if _url is Router.current().route.path @
      return "active"
    return ""

Template.sideNav.events
  "click #slide-out a": ->
    if $(window).width() < 992
      $(".button-collapse").sideNav 'hide'
  "click #sidenav-icon": ->
    Router.go "/"
