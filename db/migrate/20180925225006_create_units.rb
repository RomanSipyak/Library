class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.boolean :available, default: true
      t.references :book
      t.timestamps
    end
  end
end
