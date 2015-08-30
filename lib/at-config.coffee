AccountsTemplates.configure
  defaultLayout: 'mainLayout'
  defaultLayoutRegions: {}
  defaultContentRegion: 'main'

  # Behavior
  confirmPassword: true
  enablePasswordChange: true
  forbidClientAccountCreation: false
  overrideLoginErrors: true
  sendVerificationEmail: false
  lowercaseUsername: false
  focusFirstInput: true

  # Appearance
  showAddRemoveServices: false
  showForgotPasswordLink: false
  showLabels: true
  showPlaceholders: true
  showResendVerificationEmailLink: false

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
    Materialize.toast "Bye!", 5000
    $('#sidenav-overlay').remove()
    FlowRouter.go "Welcome"
  onSubmitHook: (err, state) ->
    throw err if err
    switch state
      when 'signIn'
        Materialize.toast "Welcome back #{getNamePart(0)}!", 5000
      when 'signUp'
        Materialize.toast "Welcome, #{getNamePart(0)}!", 5000
    FlowRouter.redirect '/home'
  #preSignUpHook: myPreSubmitFunc,

  # Texts
  texts:
    button:
      signUp: "Register Now!"
    socialSignUp: "Register"
    socialIcons:
      "meteor-developer": "fa fa-rocket"
    title:
      forgotPwd: "Recover Your Password"


#
# Custom Registration Fields
#
AccountsTemplates.addField
    _id: 'name'
    type: 'text'
    displayName: "Full Name"
    required: true


#
# AccountsTemplate Routes
#
AccountsTemplates.configureRoute 'changePwd'
#AccountsTemplates.configureRoute 'forgotPwd'
AccountsTemplates.configureRoute 'resetPwd'
AccountsTemplates.configureRoute 'signIn'
AccountsTemplates.configureRoute 'signUp'
AccountsTemplates.configureRoute 'verifyEmail'
