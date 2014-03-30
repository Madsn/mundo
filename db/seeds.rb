# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = User.find_by_username("TestUser")
if not users
  users = User.create([{username: "TestUser", email: "test@example.com", password: "123456"},
    {username: "TestUser2", email: "test2@example.com", password: "123456"}])
end

'''
workouts = Workout.create([
{
  username: "TestUser",
  user_id: User.find_by_username("TestUser").id,
  sport: "Running",
  endo_sport_id: "13",
  distance_km: rand(5.0),
  start_time: DateTime.now(),
  duration_sec: 55
}
])
'''