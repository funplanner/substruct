class CreateProductImages < ActiveRecord::Migration
  def self.up
  create_table :product_images, :force => true do |t|
    t.integer :image_id,   :limit => 11, :default => 0, :null => false
    t.integer :product_id, :limit => 11, :default => 0, :null => false
    t.integer :rank,       :limit => 11
  end

  add_index :product_images, [:product_id, :image_id], :name => :main

  end

  def self.down
    drop_table :product_images
  end
end
