class CreateContentNodes < ActiveRecord::Migration
  def self.up
    create_table :content_nodes, :force => true do |t|
      t.string   :name,       :limit => 200, :default => "", :null => false
      t.string   :title,      :limit => 100, :default => "", :null => false
      t.text     :content
      t.datetime :display_on,                                :null => false
      t.datetime :created_on,                                :null => false
      t.string   :type,       :limit => 50,  :default => "", :null => false
    end
    add_index :content_nodes, [:name], :name => :name
    add_index :content_nodes, [:type, :id], :name => :type    
  end

  def self.down
    drop_table :content_nodes
  end
end
