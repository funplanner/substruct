class CreateRelatedProducts < ActiveRecord::Migration
  def self.up
    create_table :related_products, :id => false, :force => true do |t|
      t.integer :product_id, :limit => 11, :default => 0, :null => false
      t.integer :related_id, :limit => 11, :default => 0, :null => false
    end
    add_index :related_products, [:product_id, :related_id], :name => :related_products  unless defined?(SQLite3)
  end

  def self.down
    drop_table :related_products
  end
end
