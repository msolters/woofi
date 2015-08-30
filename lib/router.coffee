FlowRouter.route '/',
  name: "Welcome"
  action: (params, qParams) ->
    BlazeLayout.render 'mainLayout',
      main: 'welcome'
      nav: null

FlowRouter.route '/home',
  name: "Home"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  subscriptions: (params, qParams) ->
    @register "Feeders", Meteor.subscribe "Feeders"
  action: (params, qParams) ->
    BlazeLayout.render 'mainLayout',
      main: 'home'
      nav: 'internalSideNav'

FlowRouter.route '/feeder/:sn',
  name: "Feeder Console"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  subscriptions: (params, qParams) ->
    @register "Feeders", Meteor.subscribe "Feeders"
  action: (params, qParams) ->
    BlazeLayout.render 'mainLayout',
      main: 'feederConsole'
      nav: 'internalSideNav'

FlowRouter.notFound =
  action: ->
    BlazeLayout.render 'mainLayout',
      main: "pageNotFound"
      nav: null
