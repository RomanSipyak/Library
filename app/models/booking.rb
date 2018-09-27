class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :unit
  enum status: { expectation: 0, taken: 1, returned: 2 }

  validates :start_booking, :end_booking, presence: true
  validate :start_gt_current_time, :start_lt_end

  def start_lt_end
    errors.add(start_booking, 'bed: start > end') if start_booking > end_booking
  end

  def start_gt_current_time
    errors.add(start_booking, 'bed: start < current time') if start_booking < DateTime.current
  end
end