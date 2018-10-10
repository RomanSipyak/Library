class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @units = @book.units
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
      render :new
    else
      render :new
    end
  end


  def update
    @book = Book.find(params[:id])
    if @author.update(book_params)
      redirect_to books_path
    else
      render :new
    end
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    if @book
      @book.destroy
      redirect_to books_path
    else
      redirect_to books_path
    end
  end


  def book_params
    params.require(:book).permit(:id, :title, :year,
                                 :language_id, :author_id, :category_id, :description)
  end
end