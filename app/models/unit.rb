class Unit < ApplicationRecord
  belongs_to :book
  has_many :bookings, dependent: :nullify
end