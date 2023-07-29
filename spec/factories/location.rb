FactoryBot.define do
  factory :location, class: 'Location' do
    garden

    name { "#{Faker::Lorem.words(number: 2)} Location" }
    size { Faker::Number.decimal(l_digits: 2) }
    irrigated { %w[true false].random }

    factory :location_with_crops do
      transient do
        crops_count { 3 }
      end

      crops do
        Array.new(crops_count) { association(:location) }
      end
    end
  end
end
