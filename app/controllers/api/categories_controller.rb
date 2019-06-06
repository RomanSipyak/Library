module Api
  class CategoriesController < BaseController
    def index
      @categories = Category.all

      render json: @categories
    end
  end
end
