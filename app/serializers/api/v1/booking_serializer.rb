class Api::V1::BookingSerializer < ActiveModel::Serializer
  attributes :id, :booking_status
  has_one :user
  has_one :tour
end
