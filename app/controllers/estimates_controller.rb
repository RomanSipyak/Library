class EstimatesController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.find(params[:book_id])

    @estimate = if @book.estimates.by_user_id(current_user.id).count == 1
                  @book.estimates.by_user_id(current_user.id).first
                else
                  Estimate.new
                end
  end

  def create
    @book = Book.find(params[:book_id])
    @estimate = Estimate.new(book_id: params[:book_id], user_id: current_user.id, rating: params[:rating])
    if @estimate.save
      @book.rating = @book.estimates.average_rating
      @book.save
    end
    @status = "Your estimate create with rating : #{params[:rating]}"
    render :new
  end

  def update
    @estimate = Estimate.find(params[:id])
    @estimate.update(rating: params[:rating])
    if @estimate.save
      @book = @estimate.book
      @book.rating = @book.estimates.average_rating
      @book.save
    end
    @status = "Your estimate update with rating: #{params[:rating]}"
    render :new
  end
end
