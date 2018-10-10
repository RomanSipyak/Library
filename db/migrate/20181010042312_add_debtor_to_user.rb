class AddDebtorToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :debtor, :boolean, default: false
  end
end
