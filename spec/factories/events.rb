FactoryGirl.define do
  factory :event do
    name Faker::StarWars.character.gsub(/\W/, "")
    registered_application
  end
end
