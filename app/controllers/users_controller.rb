class UsersController < ApplicationController
  def index
    @users_debtor = {}
    @users = User.all
    @users.each do |user|
      @users_debtor[user] = if user.bookings.by_status(:owed).count > 0
                              'Yes'
                            else
                              'No'
                            end
    end

    def show
      p 'reeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
      @user = User.find(params[:id])
      @bookings = @user.bookings
      @bookings = current_user.bookings
      @books_booking = {}
      @bookings.each { |booking| (@books_booking[booking] = booking.unit.book) if booking.unit }
    end
  end
end
