FactoryBot.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone }
    passport { Faker::IDNumber.valid }
    profile_picture { Faker::Avatar.image }
    association :user, factory: :user
  end
end
