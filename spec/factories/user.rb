FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, max_length: 20, mix_case: true, special_characters: true) }
    zip_code { Faker::Address.zip_code[0..4] }

    factory :user_with_gardens do
      transient do
        gardens_count { 1 }
      end

      gardens do
        Array.new(gardens_count) { association(:garden) }
      end
    end
  end
end