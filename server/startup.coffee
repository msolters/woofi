Meteor.startup ->
  # Insert serial numbers of our two Photons on boot,
  # if they're not already in the DB.
  demoSNs = [
    '1e0030000a47343432313031'
    '35002a000d47343432313031'
  ]
  for _sn in demoSNs
    sn_q =
      sn: _sn
    if !SerialNumbers.findOne( sn_q )
      SerialNumbers.insert sn_q
