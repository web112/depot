class AddRatingSumToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :rating_sum, :integer, :default => 0
    add_column :products, :rating_times, :integer, :default => 0
    add_column :products, :sales, :integer, :default => 0
  end

  def self.down
    remove_column :products, :rating_sum
    remove_column :products, :rating_times
    remove_column :products, :sales
  end
end
