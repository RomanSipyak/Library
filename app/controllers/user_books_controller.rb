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

  def show_readed_books
    @books = current_user.bookings.booking_by_status_user_id(:returned, current_user.id).map {|booking| booking.unit.book}
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

    if Unit.unit_available(false, @book.id).count == @book.units_count
=begin
      order_books = Unit.unit_available(false, @book.id).order(end_booking: :desc)
=end
      order_bookings = Booking.booking_by_status_book_id(:taken, @book.id).order(end_booking: :desc)
      @day_whan_this_book_by_able = ((order_bookings.first.end_booking - DateTime.current) / 86400).to_i
    end
  end

end
