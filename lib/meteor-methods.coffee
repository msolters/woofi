Meteor.methods
  createFeeder: ( _feeder ) ->
    try
      #
      # (1) Make sure the serial number of the feeder
      #     is valid and not yet registered.
      #
      sn_q =
        sn: _feeder.sn
      _sn = SerialNumbers.findOne( sn_q )
      if _sn?
        if _sn.registered
          return {
            success: false
            msg: "Sorry, this Feeder has already been registered."
          }
        else
          #
          # Otherwise, update SN to be registered.
          #
          sn_update =
            $set:
              registered: true
          SerialNumbers.update sn_q, sn_update
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
    catch error
      return {
        success: false
        msg: "Sorry, an error occurred while creating the Feeder: #{error}"
      }

  deleteFeeder: ( _sn ) ->
    try
      #
      # (1) Delete Feeder from DB.
      #
      feeder_q =
        owner: Meteor.userId()
        sn: _sn
      removeFeeder = Feeders.remove feeder_q
      if removeFeeder
        #
        # (2) Unregister associated serial number.
        #
        sn_q =
          sn: _sn
        sn_update =
          $set:
            registered: false
        SerialNumbers.update sn_q, sn_update
        return {
          success: true
          msg: "Feeder successfully removed."
        }
      else
        return {
          success: false
          msg: "You have insufficient privileges to remove this Feeder."
        }
    catch error
      return {
        success: false
        msg: "Sorry, an error occurred while deleting the Feeder: #{error}"
      }
