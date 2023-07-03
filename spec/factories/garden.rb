FactoryBot.define do
  factory :garden do
    name { "#{Faker::Lorem.words(number: 2)} Garden" }
  end
end
