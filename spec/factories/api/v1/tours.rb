FactoryBot.define do
  factory :api_v1_tour, class: 'Api::V1::Tour' do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    duration { Faker::Number.number(digits: 1) }
    image { Faker::Avatar.image }
    category { create(:api_v1_category)}
    admin { create(:admin)}

    transient do
      tour_dates_count { 2 }
      prices_count { 2 }
      destinations_count { 2 }
      activities_count { 2 }
    end

    after(:build) do |tour, evaluator|
      tour.tour_dates << build_list(:api_v1_tour_date, evaluator.tour_dates_count, tour: tour)
      tour.prices << build_list(:api_v1_price, evaluator.prices_count, tour: tour)
      tour.destinations << build_list(:api_v1_destination, evaluator.destinations_count, tour: tour)
      tour.activities << build_list(:api_v1_activity, evaluator.activities_count, tour: tour)
    end

  end
end
