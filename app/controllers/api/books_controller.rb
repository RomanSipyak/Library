module Api
  class BooksController < BaseController
    def index
      @books = Book.filter(params.slice(:by_language_ids, :by_authors_ids, :by_category_ids, :by_year, :by_title_or_name_fo_author, :by_author_name, :by_category_title))
                   .page params[:page]
      render json: @books
    end
  end
end
