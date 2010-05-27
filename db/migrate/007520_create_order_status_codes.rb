class CreateOrderStatusCodes < ActiveRecord::Migration
  def self.up
    create_table :order_status_codes, :force => true do |t|
      t.string :name, :limit => 30, :default => '', :null => false
    end
  
    add_index :order_status_codes, [:name], :name => :name unless defined?(SQLite3)
  end

  def self.down
    drop_table :order_status_codes
  end
end
