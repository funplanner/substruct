class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections, :force => true do |t|
      t.string  :name,      :limit => 100, :default => "", :null => false
      t.integer :rank,      :limit => 11
      t.integer :parent_id, :limit => 11,  :default => 0,  :null => false
    end
  end

  def self.down
    drop_table :sections
  end
end
