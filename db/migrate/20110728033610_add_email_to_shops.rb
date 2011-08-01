class AddEmailToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :email, :string
  end

  def self.down
    remove_column :shops, :email
  end
end
