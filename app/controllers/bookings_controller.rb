class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create

  end

  def delete
  end

  def update
  end

  def update_bookings_statuses

  end

  def update_bookings_status_on_returned

  end

  def update_bookings_status_on_taken

  end

  def edit

  end

  def show
  end

  def new
    @booking = if !params[:booking_id].nil?
                 Booking.find(params[:booking_id])
               else
                 Booking.new
               end
  end
end
