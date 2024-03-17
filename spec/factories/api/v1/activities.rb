FactoryBot.define do
  factory :api_v1_activity, class: 'Api::V1::Activity' do
    name { "MyString" }
    tour { nil }
  end
end
