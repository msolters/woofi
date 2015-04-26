Meteor.methods
  #################################################################
  #           CREATE
  #################################################################
  ###
  #   Validate and create a new WooFi user account
  ###
  createNewUser: (_user) ->
    # (1) validate name
    if _user.name.length is 0
      return {
        success: false
        msg: "Please provide your full name!"
      }
    # (2) validate e-mail
    if !validateEmail.test _user.email
      return {
        success: false
        msg: "Please provide a valid e-mail!"
      }
    # (3) validate passwords
    if _user.password.length < 6
      return {
        success: false
        msg: "Your password must be 6 characters or more."
      }
    else
      if _user.password isnt _user.password_confirm
        return {
          success: false
          msg: "Please make sure your passwords match!"
        }
    # (4) Finally, if we've gotten this far, let's make a user:
    Accounts.createUser
      email: _user.email
      password: _user.password
      profile:
        name: _user.name
    return {
      success: true
      msg: "Nice work, bone daddy!  Welcome aboard!"
    }
  createNewPet: (_pet) ->
    # (1) Validate pet name
    if _pet.name.length is 0
      return {
        success: false
        msg: "Please enter your pet's name."
      }
    # (2) Validate pet type
    #if _pet.type
    _pet.owner = Meteor.userId()
    petID = Pets.insert(_pet)
    return {
      success: true
      msg: "Woohoo! #{_pet.name} has been added to the WooFi system :)"
      petID: petID
    }

  #################################################################
  #           END CREATE
  #################################################################
