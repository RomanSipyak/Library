class AddImageTextToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :image_data, :text
  end
end
