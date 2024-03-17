FactoryBot.define do
  factory :api_v1_destination, class: 'Api::V1::Destination' do
    name { "MyString" }
    description { "MyText" }
    tour { nil }
  end
end
