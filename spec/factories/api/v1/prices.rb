FactoryBot.define do
  factory :api_v1_price, class: 'Api::V1::Price' do
    amount { 1.5 }
    currency { "MyString" }
    tour { nil }
  end
end
