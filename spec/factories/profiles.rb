FactoryBot.define do
  factory :profile do
    first_name { "MyString" }
    last_name { "MyString" }
    phone_number { "MyString" }
    passport { "MyString" }
    profile_picture { "MyString" }
    user { nil }
  end
end
