class AuthorsController < ApplicationController
  def new
    @author = if !params[:author_id].nil?
                Author.find(params[:author_id])
              else
                Author.new
              end
  end

  def index
    @authors = Author.all
  end


  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to authors_path
    else
      render :new
    end
  end

  def show
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      @status = 'Author Create'
      @author = Author.new
      render :new
    else
      render :new
    end
  end

  def destroy
    @author = Author.find_by(id: params[:id])
    if @author
      @author.destroy
      redirect_to authors_path
    else
      redirect_to authors_path
      return
    end

  end

  def author_params
    params.require(:author).permit(:name, :biography)
  end
end
