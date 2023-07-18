FactoryBot.define do
  factory :garden do
    name { "#{Faker::Lorem.words(number: 2)} Garden" }
    # TODO: add size

    # TODO: add traits
  end
end
