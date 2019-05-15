module ForUser
  class BooksController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, on: [:index, :show]

    def index
      @languages = Language.all
      @categories = Category.all
      @authors = Author.all
      @years = Array.new(Time.now.year - 999) {|index| [(index + 1000).to_s, index + 1000]} << ['No filtre', nil]
      @books = Book.filter(params.slice(:by_language_ids, :by_authors_ids, :by_category_ids, :by_year, :by_title_or_name_fo_author))
                   .page params[:page]
      @free_units_count = {}
      @books.each do |book|
        @free_units_count[book] = Unit.unit_available(true, book.id).count
      end
    end

    def show
      @book = Book.find(params[:id])
      @free_units_count = {}
      @free_units_count[@book] = Unit.unit_available(true, @book.id).count

      if Unit.unit_available(false, @book.id).count == @book.units_count
        order_bookings = Booking.booking_by_status_book_id(:taken, @book.id).order(end_booking: :desc)
        unless order_bookings.empty?
          @day_whan_this_book_by_able = ((order_bookings.first.end_booking - DateTime.current) / 86_400).to_i
        end
      end
      @review = Estimate.new
    end

    def show_taken_books
      @books_booking = {}
      bookings = current_user.bookings.by_status(:taken).page params[:page]
      @books = bookings.map {|booking| booking.unit.book}
      # костиляка страшна
      @books = Book.where(id: @books.map(&:id))
      @books = @books.page params[:page]
      bookings.each {|booking| @books_booking[booking.unit.book] = booking}
    end

    def show_readed_books
      @books = current_user.bookings.booking_by_status_user_id(:returned, current_user.id).map {|booking| booking.unit.book}
    end
  end
end