class Api::V1::Category < ApplicationRecord
  belongs_to :admin
  has_many :tours
end
