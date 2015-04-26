###
#   Define Before Hooks
###
beforeHooks =
  #   Used to limit access by logged in status
  loginRequired: ->
    if !Meteor.user()?
      if Meteor.loggingIn() is true
        @render 'loading'
      else
        @render 'login'
    else
      @next()
  #   Redirects logged in users to /
  logoutRequired: ->
    if Meteor.user()?
      Router.go '/'
    else
      if Meteor.loggingIn()
        @render 'loading'
      else
        @next()
  #   Moves screen to top of page:
  scrollUp: ->
    $('body,html').scrollTop(0)
    @next()


###
#   Define Router Map
###
Router.map ->
  @route 'Home',
    path: '/'
    template: 'home'
    data: ->

  @route 'Login',
    path: '/login'
    template: 'login'

  @route 'Register',
    path: '/register'
    template: 'register'

###
#   Configure & Initialize Router
###
Router.configure
  layoutTemplate: 'master'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'

Router.onBeforeAction 'loading'
Router.onBeforeAction beforeHooks.logoutRequired, {only: ['Login', 'Register']}
Router.onBeforeAction beforeHooks.loginRequired, {except: ['Home', 'Login', 'Register']}
