FactoryBot.define do
  factory :note, class: 'Note' do
    crop

    body { Faker::Coffee.notes }
  end
end