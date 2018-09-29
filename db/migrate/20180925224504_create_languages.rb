class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :language, null: false
      t.integer :books_count
    end
  end
end