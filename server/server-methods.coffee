Meteor.methods
  ###
  #   Updates the Feeder with serial number sn to be online or offline.
  ###
  updateFeederOnlineStatus: ( _online, sn ) ->
    try
      feeder_q =
        sn: sn
      feeder_update =
        $set:
          online: _online
      Feeders.update feeder_q, feeder_update
      return {
        success: true
        msg: "Feeder ##{sn} -> { online: #{_online} }"
      }
    catch error
      return {
        success: false
        msg: "An error occurred updating the online status of Feeder ##{sn}: #{error}"
      }
