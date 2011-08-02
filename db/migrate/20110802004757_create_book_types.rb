class CreateBookTypes < ActiveRecord::Migration
  def self.up
    create_table :book_types do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :book_types_products, :id => false do |t|
      t.integer :product_id
      t.integer :book_type_id   
    end
  end

  def self.down
    drop_table :book_types_products 
    drop_table :book_types
  end
end
