FactoryBot.define do
  factory :crop, class: 'Crop' do
    name { Faker::Food.vegetables }
    variety { Faker::Lorem.words(number: 2) }
    days_to_maturity { Faker::Number.between(from: 21, to: 120) }
    date_planted { Faker::Date.between(from: 25.days.ago, to: Date.today) }
    active { true }

    trait :inactive_crop do
      active { false }
    end
  end
end
