module Admin
  class BooksController < ApplicationController
    before_action :authenticate_user!, :user_admin!

    def index
      @languages = Language.all
      @categories = Category.all
      @authors = Author.all
      @years = Array.new(Time.now.year - 999) {|index| [(index + 1000).to_s, index + 1000]} << ['No filtre', '']
      @books = Book.filter(params.slice(:by_language_ids, :by_authors_ids, :by_category_ids, :by_year, :by_title_or_name_for_author))
                   .page params[:page]
      render 'admin/books/index', :locals => {:fbookupload => "yes"}

    end

    def show
      @book = Book.find(params[:id])
      @units = @book.units
      @units_owner_name = {}
      @units.each do |unit|
        @units_owner_name[unit] = unit.bookings.by_status(:taken).first.user.username unless unit.bookings.by_status(:taken).first.nil?
      end
      @free_units_count = Unit.unit_available(true, @book.id).count
      @taken_units_count = Unit.unit_available(false, @book.id).count
    end

    def new
      @book = if !params[:book_id].nil?
                Book.find(params[:book_id])
              else
                Book.new
              end
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        @status = 'Book Create'
        @book = Book.new
      end
      render :new
    end

    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to admin_books_path
      else
        render :new
      end
    end
    def recovery
      @book = Book.find(params[:book_id])
      @book.in_history = false
      @book.save
      redirect_to admin_books_path
    end
    def destroy
      @book = Book.find_by(id: params[:id])
      if @book
        if @book.update(in_history: true)
          @book.units.update_all(in_history: true, updated_at: DateTime.now)
          @book.bookings.by_status(:expectation).destroy_all
          redirect_to admin_books_path
        end
      end
    end

    def user_admin!
      redirect_to root_path unless current_user.admin
    end

    def book_params
      params.require(:book).permit(:id, :title, :year,
                                   :language_id, :author_id, :category_id, :description, :image)
    end
  end
end