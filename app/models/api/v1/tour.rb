class Api::V1::Tour < ApplicationRecord
  belongs_to :category
  belongs_to :admin
  validates :name, :description, :duration, presence: true
  validates :name, uniqueness: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }

end
