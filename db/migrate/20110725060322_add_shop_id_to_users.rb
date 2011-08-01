class AddShopIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :shop_id, :integer
  end

  def self.down
    remove_column :users, :shop_id
  end
end
