class UserBookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
    @books_booking = {}
    @bookings.each {|booking| (@books_booking[booking] = booking.unit.book) if booking.unit }
  end

  def create
    if current_user.bookings.by_status(:taken).count < 4 && !(current_user.bookings.by_status(:owed).count > 0)
      booking = Booking.new
      free_units = Unit.unit_available(true, params[:book_id])
      booking[:start_booking] = DateTime.current + 4.days
      booking[:end_booking] = DateTime.current + 24.days
      booking.unit = free_units.first
      booking.book_title = unit.book.title
      booking.author_name = unit.book.author.name
      booking.user = current_user
      booking[:code] = SecureRandom.hex(7)
      booking.save
    end
    redirect_to user_bookings_path
  end

end
