class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create

  end

  def destroy
    @booking = Booking.find_by(id: params[:id])
    if @booking
      @booking.destroy
      redirect_to bookings_path
    else
      redirect_to bookings_path
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(status: booking_params[:status])
    @booking.update(end_booking: (@booking.end_booking + params[:continue_booking].to_i.days))
    redirect_to bookings_path
  end

  def update_bookings_statuses
    Booking.by_status(:taken).each do |booking|
      if booking.end_booking < DateTime.current
        booking.update_columns(status: :owed)
      end
    end
    Booking.by_status(:expectation).each do |booking|
      if booking.start_booking < DateTime.current
        booking.destroy
      end
    end
    redirect_to bookings_path
  end

  def update_booking_status
    @booking = Booking.find(params[:booking_id])
    if (params[:status] == "taken")
      @booking.unit.update(available: false)
    end
    if (params[:status] == "returned")
      @booking.unit.update(available: true)
    end
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
