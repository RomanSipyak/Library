class ChangeBooksCountForCategories < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :books_count, :integer, default: 0
  end
end
