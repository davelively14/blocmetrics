FactoryGirl.define do
  name_template = Faker::StarWars.character.gsub(/\W/, "")

  factory :event do
    name sequence(:name){|n| "#{name_template}#{name}"}
    registered_application
  end
end
