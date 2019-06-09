module ForUser
  class BookingsController < ApplicationController
    before_action :authenticate_user!

    def index
      @bookings = current_user.bookings.page params[:page]
      @books_booking = {}
      @bookings.each {|booking| (@books_booking[booking] = booking.unit.book) if booking.unit}
    end

    def create
      if (current_user.bookings.by_status(:taken).count < 4 && !(current_user.bookings.by_status(:owed).count > 0) && Booking.booking_by_status_book_id("expectation",params[:book_id]).count < 1)
        booking = Booking.new
        free_units = Unit.unit_available(true, params[:book_id])
        booking[:start_booking] = DateTime.current + 4.days
        booking[:end_booking] = DateTime.current + 24.days
        unit = free_units.first
        booking.unit = unit
        booking.book_title = unit.book.title
        booking.author_name = unit.book.author.name
        booking.user = current_user
        booking[:code] = SecureRandom.hex(7)
        booking.save
      end
      redirect_to for_user_bookings_path
    end

    def destroy
      @booking = Booking.find_by(id: params[:id])
      if @booking && @booking.status == "expectation"
        @booking.destroy
        redirect_to for_user_bookings_path
      else
        redirect_to for_user_bookings_path
        return
      end
    end

  end
end