class UserBooksController < ApplicationController
  def index
    @books = Book.all
    @free_books = {}
    @books.each do |book|
      @free_books[book] = Unit.unit_available(true, book.id).count
    end
  end

  def show_taken_books
    @books = current_user.bookings.by_status(:taken).map {|booking| booking.unit.book}
  end


  def edit
  end

  def update
  end

  def destroy
  end

  def new
  end

  def create
  end

  def show
    @book = Book.find(params[:id])
  end

end
