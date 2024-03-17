class Api::V1::TourSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :duration, :image
  has_one :category
  has_one :admin
end