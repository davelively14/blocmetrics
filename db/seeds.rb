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

puts "Seed complete"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} apps created"
