class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.text :biography
      t.integer :books_count
    end
  end
end
