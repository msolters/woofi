Meteor.publish "Pets", (slug={}) ->
  slug.owner = @userId
  console.log slug
  return Pets.find(slug)
Meteor.publish "Feeders", (slug={}) ->
  slug.owner = @userId
  return Feeders.find(slug)
