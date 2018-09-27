class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.text :description, null: false
      t.integer :units_count
      t.float :rating, default: 0.0
      t.references :author
      t.references :category
      t.references :language
      t.timestamps
    end
  end
end
