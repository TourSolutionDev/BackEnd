FactoryBot.define do
  factory :api_v1_tour_date, class: 'Api::V1::TourDate' do
    start_date { "2024-03-17" }
    end_date { "2024-03-17" }
    tour { nil }
  end
end
