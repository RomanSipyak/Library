class UserBooksController < ApplicationController
  def index
    @books = Book.all
    @free_books = {}
    @books.each do |book|
      @free_books[book] = Unit.unit_available(true, book.id).count
    end
  end

  def show_taken_books
    @books_booking = {}
    bookings = current_user.bookings.by_status(:taken)
    @books = bookings.map {|booking| booking.unit.book}
    bookings.each {|booking| @books_booking[booking.unit.book] = booking}
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
    @free_books = {}
    @free_books[@book] = Unit.unit_available(true, @book.id).count
  end

end
