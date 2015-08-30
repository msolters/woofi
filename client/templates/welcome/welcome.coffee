###
#     Template.welcome
###
Template.welcome.created = ->
  @autorun =>
    if Meteor.userId()?
      FlowRouter.redirect '/home'
