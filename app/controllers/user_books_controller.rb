class UserBooksController < ApplicationController
  def index
    @books = Book.all
    @free_books = {}
    @books.each do |book|
      @free_books[book] = Unit.unit_available(true, book.id).count
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def new
  end

  def create
    end

  def show
  end

end
