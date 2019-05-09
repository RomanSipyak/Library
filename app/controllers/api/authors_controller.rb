module Api
  class AuthorsController < BaseController
    before_action :find, only: [:show]

    def index
      @authors = Author.all

      render json: @authors
    end

    def show
      render json: @author
    end

    private

    def find
      @author = Author.find_by(name: params[:name])
      if @author
        render json: @author
      else
        @errors = @author.errors.full_messages
        render json: @errors
      end
    end
  end
end
