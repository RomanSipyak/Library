module Admin
  class AuthorsController < ApplicationController
    before_action :authenticate_user!, :user_admin!
    skip_before_action :authenticate_user!, on: %i[index]

    def index
      @authors = Author.all.page params[:page]
    end

    def show
      @author = Author.find(params[:id])
    end

    def new
      @author = if !params[:author_id].nil?
                  Author.find(params[:author_id])
                else
                  Author.new
                end
    end

    def create
      @author = Author.new(author_params)
      if @author.save
        @status = 'Author Create'
        @author = Author.new
      end
      render :new
    end

    def update
      @author = Author.find(params[:id])
      if @author.update(author_params)
        redirect_to admin_authors_path
      else
        render :new
      end
    end

    def destroy
      @author = Author.find_by(id: params[:id])
      if @author
        @author.destroy
        redirect_to admin_authors_path
      else
        redirect_to admin_authors_path
        return
      end
    end

    def user_admin!
      redirect_to root_path unless current_user.admin
    end

    def author_params
      params.require(:author).permit(:name, :biography, :image)
    end
  end
end