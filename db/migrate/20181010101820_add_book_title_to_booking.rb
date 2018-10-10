class AddBookTitleToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :book_title, :string
  end
end
