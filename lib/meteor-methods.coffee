Meteor.methods
  createFeeder: ( _feeder ) ->
    try
      #
      # (1) Make sure the serial number of the feeder
      #     is valid and not yet registered.
      #
      registeredSN_q =
        sn: _feeder.sn
      _sn = SerialNumbers.findOne(registeredSN_q)
      if _sn?
        if _sn.registered
          return {
            success: false
            msg: "Sorry, this Feeder has already been registered."
          }
      else
        return {
          success: false
          msg: "Sorry, that's not a recognized serial number."
        }
      #
      # (2) Apply ownership to the feeder object.
      #
      _feeder.owner = Meteor.userId()
      #
      # (3) Insert the Feeder to the DB.
      #
      Feeders.insert _feeder
      return {
        success: true
        msg: "Feeder successfully created!"
      }
    catch e
      return {
        success: false
        msg: "Sorry, an error occurred: #{e}"
      }
