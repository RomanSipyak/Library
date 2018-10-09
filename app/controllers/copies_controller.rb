class CopiesController < ApplicationController

  def destroy
    @unit = Unit.find_by(id: params[:id])
    @unit.destroy
    @book = Book.find(params[:book_id])
    redirect_to book_path(@book)
  end

  def create_unit_for_book
    @unit = Unit.new(book_id: params[:book_id])
    @book = Book.find(params[:book_id])
    if @unit.save && @book
      @unit = Book.new
      redirect_to books_path
    else
      redirect_to books_path
    end
  end

  def delete_last_unit_for_book
    @units = Unit.where(book_id: params[:book_id])
    if !@units.empty?
      @units.last.destroy
      redirect_to books_path
    else
      redirect_to books_path
    end
  end

  def new
  end

end
