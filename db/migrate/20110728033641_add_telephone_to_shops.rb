class AddTelephoneToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :telephone, :string
  end

  def self.down
    remove_column :shops, :telephone
  end
end
