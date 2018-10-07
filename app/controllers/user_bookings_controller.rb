class UserBookingsController < ApplicationController
  def index
  end

  def create
    if current_user.bookings.by_status(:taken).count < 4 && !(current_user.bookings.by_status(:owed).count > 0)
      booking = Booking.new
      free_units = Unit.unit_available(true, params[:book_id])
      booking[:start_booking] = Time.current + 4.days
      booking[:end_booking] = Time.current + 24.days
      booking.unit = free_units.first
      booking.user = current_user
      booking[:code] = SecureRandom.hex(7)
      booking.save
    end
    redirect_to user_books_path
  end

  def delete
  end

  def update
  end

  def edit
  end

  def show
  end

  def new
  end
end
