FactoryBot.define do
  factory :api_v1_tour_date, class: 'Api::V1::TourDate' do
    start_date { Faker::Date.between(from: '2021-03-17', to: '2024-03-17') }
    end_date { Faker::Date.between(from: start_date, to: '2024-03-17') }
    tour { create(:api_v1_tour)}
  end
end
