Meteor.publish 'Feeders', ( slug={} ) ->
  slug.owner = @userId
  Feeders.find( slug )
