class CreatePreferences < ActiveRecord::Migration
  def self.up
  create_table :preferences, :force => true do |t|
    t.string :name,  :default => '', :null => false
    t.string :value, :default => ''
  end

  add_index :preferences, [:name], :name => :namevalue
  end

  def self.down
    drop_table :preferences
  end
end
