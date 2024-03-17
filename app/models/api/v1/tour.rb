class Api::V1::Tour < ApplicationRecord
  belongs_to :category
  belongs_to :admin
end
