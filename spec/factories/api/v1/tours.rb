FactoryBot.define do
  factory :api_v1_tour, class: 'Api::V1::Tour' do
    name { "MyString" }
    description { "MyText" }
    duration { 1 }
    image { "MyString" }
    category { nil }
    admin { nil }
  end
end
