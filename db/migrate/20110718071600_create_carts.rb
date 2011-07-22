class CreateCarts < ActiveRecord::Migration
  def self.up
  end

  def self.down
    drop_table :carts
  end
end
