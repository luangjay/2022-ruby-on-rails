class AddQuantityToInventory < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :quantity, :integer
  end
end
