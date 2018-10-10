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
      @user = User.find(params[:id])
      @debtor = (@user.bookings.by_status(:owed).count > 0) ? 'Yes' : 'No'
    end
  end
end
