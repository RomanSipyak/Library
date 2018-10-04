class ChangeUnitsCountForBooks < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :units_count, :integer, default: 0
  end
end
