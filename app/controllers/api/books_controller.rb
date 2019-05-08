module Api
  class BooksController < BaseController

    def index
      @books = Book.all

      render json: @books
    end
  end
end
