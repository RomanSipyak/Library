class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :unit
  enum status: { expectation: 0, taken: 1, returned: 2,
                 owed: 3 }

  validates :start_booking, :end_booking, presence: true
  validate :start_gt_current_time, :start_lt_end
  validates :code, presence: true, uniqueness: true

  def start_lt_end
    errors.add(:start_booking, 'bed: start > end') if start_booking > end_booking
  end

  def start_gt_current_time
    errors.add(:start_booking, 'bed: start < current time') if start_booking < DateTime.current
  end

  scope :by_status, ->(status) { where(arel_table[:status].eq(status)) }
  scope :by_book_title_or_author_name, ->(by_book_title_or_author_name) {
    where(arel_table[:book_title].matches("%#{by_book_title_or_author_name}%"))
      .or(arel_table[:author_name].matches("%#{by_book_title_or_author_name}%"))
  }
  scope :by_title_or_name_fo_author, ->(by_title_or_name_fo_author) do
    author = Author.arel_table
    book = Book.arel_table
    joins(:author).where(author[:name].matches("%#{by_title_or_name_fo_author}%").or(book[:title].matches("%#{by_title_or_name_fo_author}%")))
  end

  def self.booking_by_status_book_id(status, id)
    #     units = Unit.arel_table
    booking_table = Booking.arel_table
    #     query = ((booking_table.join(units).on(units[:id].eq(booking_table[:unit_id])).and(booking_table[:status].eq(status)).and (units[:book_id].eq(id)))).to_sql
    #     Booking.where(query)
    #     self.where(booking_table[:status].eq(status))
    #     self.where(units[:book_id].eq(id))
    joins(:unit).where(units: { book_id: id }).where(booking_table[:status].eq(status))
  end

  def self.booking_by_username(booking_by_username)
    user = User.arel_table
    joins(:user).where(user[:username].matches("%#{booking_by_username}%"))
  end

  def self.booking_by_status_user_id(status, id)
    booking_table = Booking.arel_table
    where(booking_table[:status].eq(status)
              .and(booking_table[:user_id].eq(id)))
  end
end
