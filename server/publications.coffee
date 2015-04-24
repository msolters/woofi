Meteor.publish "Feeders", (slug={}) ->
  slug.owner = @userId
  return Feeders.find(slug)
