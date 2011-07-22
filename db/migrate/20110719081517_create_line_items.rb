class CreateLineItems < ActiveRecord::Migration
  def self.up
  end

  def self.down
    drop_table :line_items
  end
end
