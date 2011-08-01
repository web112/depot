class AddImageUrlToShops < ActiveRecord::Migration
  def self.up
    add_column :shops, :image_url, :string
  end

  def self.down
    remove_column :shops, :image_url
  end
end
