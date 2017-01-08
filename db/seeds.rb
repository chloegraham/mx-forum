# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name:  "Example",
			       last_name: "User",
             email: "example@gem.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  first_name  = Faker::Name.name
  email = "example-#{n+1}@gem.org"
  password = "password"
  role = "user"
  User.create!(first_name:  first_name,
               email: email,
               role: role,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.characters(char_count = 15)
  users.each { |user| user.posts.create!(title: title, content: content) }
end