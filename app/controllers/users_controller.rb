class UsersController < ApplicationController
  before_action :authenticate_user!, :user_admin!

  def index
    @users = User.filter(params.slice(:by_debtor)).page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @bookings = @user.bookings
    @books_booking = {}
    @bookings.each {|booking| (@books_booking[booking] = booking.unit.book) if booking.unit}
  end

  def update
    @user = User.find(params[:user_id])
    @user.update(admin: params[:admin])
    redirect_to user_path(@user)
  end

  def user_admin!
    redirect_to root_path unless current_user.admin
  end
end
