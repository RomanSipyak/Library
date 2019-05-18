class AddInHistoryToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :in_history, :boolean, default: false
  end
end
