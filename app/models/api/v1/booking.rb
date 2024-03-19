class Api::V1::Booking < ApplicationRecord
  enum booking_status: { pending: 'pending', confirmed: 'confirmed', cancelled: 'cancelled' }
  belongs_to :user
  belongs_to :tour
  validates :tour_id, :user_id, :booking_status, presence: true
  scope :by_user, ->(user) { where(user: user) }
end
