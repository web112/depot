class CreateProducts < ActiveRecord::Migration
  def self.up
    end
  end

  def self.down
    drop_table :products
  end
end
