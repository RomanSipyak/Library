module Admin
  class BookingsController < ApplicationController
    before_action :authenticate_user!, :user_admin!
    skip_before_action :authenticate_user!, on: %i[index]

    def index
      @bookings = Booking.filter(params.slice(:by_status, :by_book_title_or_author_name_or_code))
                      .page params[:page]
    end

    def new
      @booking = if !params[:booking_id].nil?
                   Booking.find(params[:booking_id])
                 else
                   Booking.new
                 end
    end

    def update
      @booking = Booking.find(params[:id])
      @booking.update(status: booking_params[:status])
      @booking.update(end_booking: (@booking.end_booking + params[:continue_booking].to_i.days))
      redirect_to admin_bookings_path
    end

    def destroy
      @booking = Booking.find_by(id: params[:id])
      @booking.destroy if @booking
      redirect_to admin_bookings_path
    end

    def update_bookings_statuses
      Booking.by_status(:taken).each do |booking|
        if booking.end_booking < DateTime.current
          booking.update_columns(status: :owed)
          booking.user.update(debtor: true)
        end
      end
      Booking.by_status(:expectation).each do |booking|
        booking.destroy if booking.start_booking < DateTime.current
      end
      redirect_to admin_bookings_path
    end

    def update_booking_status
      @booking = Booking.find(params[:booking_id])
      if params[:status] == 'taken'
        @booking.unit.update(available: false)
        @booking.user.update(debtor: false) if @booking.user.debtor
      end
      if params[:status] == 'returned'
        @booking.unit.update(available: true)
        @booking.user.update(debtor: false) if @booking.user.debtor
      end
      @booking.update_column(:status, params[:status])
      redirect_to admin_bookings_path
    end

    def user_admin!
      redirect_to root_path unless current_user.admin
    end

    def booking_params
      params.require(:booking).permit(:status)
    end
  end
end