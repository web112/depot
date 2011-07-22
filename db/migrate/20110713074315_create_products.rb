class CreateProducts < ActiveRecord::Migration
  def self.up
  end

  def self.down
    drop_table :products
  end
end
