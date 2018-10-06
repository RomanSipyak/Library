class ChangeBooksCountForLanguages < ActiveRecord::Migration[5.2]
  def change
    change_column :languages, :books_count, :integer, default: 0
  end
end
