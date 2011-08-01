class AddShopIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :shop_id, :integer
  end

  def self.down
    remove_column :orders, :shop_id
  end
end
