class CreateHistoryItems < ActiveRecord::Migration
  def self.up
    create_table :history_items do |t|
      
      t.string :product_name
      t.decimal :price
      t.integer :product_id
      
      t.string :shop_name
      t.integer :shop_id
      
      t.string :shop_email
      t.string :shop_telephone
      
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :history_items
  end
end
