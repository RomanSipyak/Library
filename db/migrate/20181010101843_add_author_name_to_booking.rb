class AddAuthorNameToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :author_name, :string
  end
end
