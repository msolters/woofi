beforeHooks =
  ###
  #   Used to limit access by logged in status
  ###
  loginRequired: ->
    if !Meteor.user()?
      if Meteor.loggingIn() is true
        @render 'loading'
      else
        @render 'login'
    else
      @next()
  ###
  #   Moves screen to top of page:
  ###
  scrollUp: ->
    $('body,html').scrollTop(0)
    @next()

Router.map ->
  @route 'Home'
    path: '/'
    template: 'home'
    waitOn: ->
    data: ->


Router.configure
  layoutTemplate: 'master'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'

Router.onBeforeAction 'loading'
Router.onBeforeAction beforeHooks.loginRequired, {except: ['Home']}
