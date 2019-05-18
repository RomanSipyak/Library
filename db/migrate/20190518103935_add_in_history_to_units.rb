class AddInHistoryToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :in_history, :boolean, default: false
  end
end
