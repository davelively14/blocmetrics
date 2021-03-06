user = User.create!(
  username: "dlively",
  email: "dlively@resurgens.io",
  password: "password",
  password_confirmation: "password"
)

5.times do
  RegisteredApplication.create!(
    name: Faker::GameOfThrones.character.gsub(/\W/, ""),
    url: Faker::Internet.url,
    user_id: user.id
  )
end

apps = RegisteredApplication.all

example_cats = []
5.times {example_cats << Faker::StarWars.character.gsub(/\W/, "")}

100.times do
  Event.create!(
    name: example_cats.sample,
    registered_application: apps.sample
  )
end

RegisteredApplication.create!(
  name: "Local Host 4000",
  url: "http://localhost:4000",
  user_id: user.id
)

RegisteredApplication.create!(
  name: "Checkpoint 6 Test",
  url: "http://registered_application.com",
  user_id: user.id
)

puts "Seed complete"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} apps created"
puts "#{Event.count} events created"
