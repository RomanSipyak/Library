class Unit < ApplicationRecord
  belongs_to :book , counter_cache: :units_count
  has_many :bookings, dependent: :nullify
end