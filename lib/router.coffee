FlowRouter.route '/',
  name: "Welcome"
  action: (params, qParams) ->
    BlazeLayout.render 'mainLayout',
      main: 'welcome'
      nav: null

FlowRouter.route '/home',
  name: "Home"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action: (params, qParams) ->
    BlazeLayout.render 'mainLayout',
      main: 'home'
      nav: 'internalSideNav'

FlowRouter.notFound =
  action: ->
    BlazeLayout.render 'mainLayout',
      main: "pageNotFound"
