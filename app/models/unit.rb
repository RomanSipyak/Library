class Unit < ApplicationRecord
  belongs_to :book, counter_cache: :units_count
  has_many :bookings, dependent: :nullify




  # scope :by_booking_status, ->(status) do
  #   includes(:bookings).where("boooking.status = :status",status: status)
  # end


  def self.unit_available(avilable, id)
    unit_table = Unit.arel_table
    Unit.where(unit_table[:available].eq(avilable)
                   .and(unit_table[:book_id].eq(id)))
  end
end