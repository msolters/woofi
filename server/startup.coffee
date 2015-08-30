Meteor.startup ->
  #
  # (1) Insert serial numbers of our two Photons on boot,
  #     if they're not already in the DB.
  #
  demoSNs = [
    '1e0030000a47343432313031'
    '35002a000d47343432313031'
  ]
  for _sn in demoSNs
    sn_q =
      sn: _sn
    if !SerialNumbers.findOne( sn_q )
      SerialNumbers.insert
      sn: _sn
      registered: false

  #
  # (2) Login to Spark
  #
  Spark.login
    accessToken: 'affc4a88e94c0c996d1530931a0dce9dab8b3371'
  .then (token) ->
    console.log 'Logged into Spark:', token
  .catch (err) ->
    console.error 'Login to Spark failed:', err

  Spark.getEventStream false, 'mine', Meteor.bindEnvironment (data) ->
    console.log data
    switch data.name
      when 'spark/status'
        switch data.data
          when 'online'
            Meteor.call 'updateFeederOnlineStatus', true, data.coreid, (err, resp) ->
              console.log resp.msg
          when 'offline'
            Meteor.call 'updateFeederOnlineStatus', false, data.coreid, (err, resp) ->
              console.log resp.msg
