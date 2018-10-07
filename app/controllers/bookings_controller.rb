class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create

  end

  def delete
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(status: booking_params[:status])
    @booking.update(end_booking: (@booking.end_booking + params[:continue_booking].to_i.days))
    redirect_to bookings_path
  end

  def update_bookings_statuses

  end

  def update_booking_status
    @booking = Booking.find(params[:booking_id])
    @booking.update(status: params[:status])
    redirect_to bookings_path
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
  def booking_params
    params.require(:booking).permit(:status)
  end
end
