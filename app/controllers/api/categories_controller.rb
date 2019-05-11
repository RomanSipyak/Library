module Api
  class CategoriesController < BaseController
    before_action :find, only: [:show]

    def index
      @categories = Category.all

      render json: @categories
    end

    def show
      render json: @category.books
    end

    private

    def find
      @category = Category.find_by(title: params[:title])
      if @category
        return @category
      else
        @errors = @category.errors.full_messages
        render json: @errors
      end
    end
  end
end
