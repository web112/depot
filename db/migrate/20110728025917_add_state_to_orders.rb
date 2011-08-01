class AddStateToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :state, :string, :default => "pending"
  end

  def self.down
    remove_column :orders, :state
  end
end
