class AddDescriptionToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :description, :string
  end

  def self.down
    remove_column :shops, :description
  end
end
