class CreateEstimates < ActiveRecord::Migration[5.2]
  def change
    create_table :estimates do |t|
      t.float :rating, default: 0.0
      t.references :user
      t.references :book
      t.timestamps
    end
  end
end
