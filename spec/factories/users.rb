FactoryGirl.define do
  pw = Faker::Internet.password
  un = Faker::GameOfThrones.character.gsub(/\W/, "")

  factory :user do
    sequence(:email){|n| "#{un}#{n}@blocmetrics.com"}
    password pw
    password_confirmation pw
  end
end
