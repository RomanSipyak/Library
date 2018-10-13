class AddImageTextToUsers < ActiveRecord::Migration[5.2]
  change do
    add_column :users, :image_data, :text
  end
end
