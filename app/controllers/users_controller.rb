class UsersController < ApplicationController
  def new;
  end

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

    def edit;
    end

    def update;
    end

    def show
      @user = User.find(params[:id])
      @debtor = if @user.bookings.by_status(:owed).count > 0
                  'Yes'
                else
                  'No'
                end
    end

    def create;
    end

    def destroy;
    end
  end
end
