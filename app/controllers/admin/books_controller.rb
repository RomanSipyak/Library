module Admin
  class BooksController < ApplicationController
    before_action :authenticate_user!, :user_admin!

    def index
      @languages = Language.all
      @categories = Category.all
      @authors = Author.all
      @years = Array.new(Time.now.year - 999) {|index| [(index + 1000).to_s, index + 1000]} << ['No filtre', nil]
      @books = Book.filter(params.slice(:by_language_ids, :by_authors_ids, :by_category_ids, :by_year, :by_title_or_name_for_author))
                   .page params[:page]
    end

    def show
      @book = Book.find(params[:id])
      @units = @book.units
      @units_owner_name = {}
      @units.each do |unit|
        @units_owner_name[unit] = unit.bookings.by_status(:taken).first.user.username unless unit.bookings.by_status(:taken).first.nil?
      end
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

    def destroy
      @book = Book.find_by(id: params[:id])
      if @book
        if @book.update(in_history: true)
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