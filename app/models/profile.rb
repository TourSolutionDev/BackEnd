class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, :phone_number, :passport, presence: true
  validates :phone_number, length: { is: 10 }, uniqueness: true
end
