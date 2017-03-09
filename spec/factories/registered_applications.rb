FactoryGirl.define do
  name_template = Faker::StarWars.character.gsub(/\W/, "")

  factory :registered_application do
    sequence(:name){|n| "#{name_template}#{n}"}
    url Faker::Internet.url
    user
  end
end
