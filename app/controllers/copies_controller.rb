class CopiesController < ApplicationController
  before_action :authenticate_user!, :user_admin!

  def destroy
    unit = Unit.find_by(id: params[:id])
    unit.destroy
    book = Book.find(params[:book_id])
    redirect_to book_path(book.id)
  end

  def create_unit_for_book
    @unit = Unit.new(book_id: params[:book_id])
    @book = Book.find(params[:book_id])
    @unit = Book.new if @unit.save && @book
    redirect_to books_path
  end

  def delete_last_unit_for_book
    @units = Unit.where(book_id: params[:book_id])
    @units.last.destroy unless @units.empty?
    redirect_to books_path
  end

  def user_admin!
    redirect_to root_path unless current_user.admin
  end
end
