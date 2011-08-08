class AddStateToShop < ActiveRecord::Migration
  def self.up
    add_column :shops, :state, :string, :default => "open"
  end

  def self.down
    remove_column :shops, :state
  end
end
