class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :unit
  enum status: {expectation: 0, taken: 1, returned: 2,
                owed: 3}

  validates :start_booking, :end_booking, presence: true
  validate :start_gt_current_time, :start_lt_end
  validates :code, presence: true, uniqueness: true

  def start_lt_end
    errors.add(:start_booking, 'bed: start > end') if start_booking > end_booking
  end

  def start_gt_current_time
    errors.add(:start_booking, 'bed: start < current time') if start_booking < DateTime.current
  end

  scope :by_status, ->(status) {where(arel_table[:status].eq(status))}

  def self.booking_by_status_book_id(status, id)


    units = Unit.arel_table
    booking_table = Booking.arel_table
=begin
    query = ((booking_table.join(units).on(units[:id].eq(booking_table[:unit_id])).and(booking_table[:status].eq(status)).and (units[:book_id].eq(id)))).to_sql
    Booking.where(query)
=end

=begin
    self.where(booking_table[:status].eq(status))
    self.where(units[:book_id].eq(id))
=end
    joins(:unit).where(units: { book_id: id }).where(booking_table[:status].eq(status))

  end
end
