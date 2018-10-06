class ChangeBooksCountForAuthors < ActiveRecord::Migration[5.2]
  def change
    change_column :authors, :books_count, :integer, default: 0
  end
end
