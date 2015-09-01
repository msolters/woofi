AccountsTemplates.configure
  defaultLayout: 'mainLayout'
  defaultLayoutRegions: {
    nav: 'externalSideNav'
  }
  defaultContentRegion: 'main'

  # Behavior
  confirmPassword: true
  enablePasswordChange: true
  forbidClientAccountCreation: false
  overrideLoginErrors: true
  sendVerificationEmail: false
  lowercaseUsername: false
  focusFirstInput: false

  # Appearance
  showAddRemoveServices: false
  showForgotPasswordLink: false
  showLabels: true
  showPlaceholders: true
  showResendVerificationEmailLink: false
  hideSignInLink: true
  hideSignUpLink: true

  # Client-side Validation
  continuousValidation: true
  negativeFeedback: false
  negativeValidation: true
  positiveValidation: true
  positiveFeedback: true
  showValidating: true

  # Privacy Policy and Terms of Use
  ###
  privacyUrl: 'privacy'
  termsUrl: 'terms-of-use'
  ###

  # Redirects
  homeRoutePath: '/'
  redirectTimeout: 4000

  # Hooks
  onLogoutHook: (err, state) ->
    throw err if err
    Materialize.toast "Bye!", 5000, "green"
    $('#sidenav-overlay').remove()
    FlowRouter.go "Welcome"
  onSubmitHook: (err, state) ->
    if err
      switch err.reason
        when 'error.accounts.Login forbidden'
          _msg = "Invalid e-mail or password."
        else
          _msg = err.reason
      Materialize.toast _msg, 5500, "red"
      return
    switch state
      when 'signIn'
        Materialize.toast "Welcome back #{getNamePart(0)}!", 5000, "green"
      when 'signUp'
        Materialize.toast "Welcome, #{getNamePart(0)}!", 5000, "green"
  #preSignUpHook: myPreSubmitFunc,

  # Texts
  texts:
    button:
      signUp: "Register"
    socialSignUp: "Register"
    socialIcons:
      "meteor-developer": "fa fa-rocket"
    title:
      forgotPwd: "Recover Your Password"


#
# Custom Registration Fields
#
email = AccountsTemplates.removeField 'email'
pwd = AccountsTemplates.removeField 'password'

AccountsTemplates.addField
    _id: 'name'
    type: 'text'
    displayName: "Full Name"
    required: true

AccountsTemplates.addField email
AccountsTemplates.addField pwd


#
# AccountsTemplate Routes
#
AccountsTemplates.configureRoute 'changePwd'
#AccountsTemplates.configureRoute 'forgotPwd'
AccountsTemplates.configureRoute 'resetPwd'
AccountsTemplates.configureRoute 'signIn',
  name: 'Sign In'
  path: '/login'
  template: 'signIn'
  layoutTemplate: 'mainLayout'
  layoutRegions:
    nav: 'externalSideNav'
  contentRegion: 'main'
AccountsTemplates.configureRoute 'signUp',
  name: 'Sign Up'
  path: '/register'
  template: 'signUp'
  layoutTemplate: 'mainLayout'
  layoutRegions:
    nav: 'externalSideNav'
  contentRegion: 'main'
AccountsTemplates.configureRoute 'verifyEmail'
