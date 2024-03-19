FactoryBot.define do
  factory :api_v1_price, class: 'Api::V1::Price' do
    amount { Faker::Number.number(digits: 4) }
    currency { Faker::Currency.code }
    tour { create(:api_v1_tour)}
  end
end
