FactoryBot.define do
  factory :garden, class: 'Garden' do
    user

    name { "#{Faker::Lorem.words(number: 2)} Garden" }
    size { Faker::Number.decimal(l_digits: 2) }
  end
end
