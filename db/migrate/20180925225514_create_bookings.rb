class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.datetime :start_booking, null: false
      t.datetime :end_booking, null: false
      t.string :code
      t.references :unit
      t.references :user
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
