class CreateAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :advertisements do |t|
      t.string :image_url
      t.string :link_url
      t.string :title
      
      t.timestamps
    end
  end

  def self.down
    drop_table :advertisements
  end
end
