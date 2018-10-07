class AddUniqueCodeForBookings < ActiveRecord::Migration[5.2]
  def change
    add_index :bookings, :code, {unique: true}
  end
end
