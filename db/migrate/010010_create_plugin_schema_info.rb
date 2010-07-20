# encoding: UTF-8
# Source Code Modifications (c) 2010 Laurence A. Lee, 
# See /RUBYJEDI.txt for Licensing and Distribution Terms
class CreatePluginSchemaInfo < ActiveRecord::Migration
  def self.up
    create_table :plugin_schema_info, :id => false, :force => true do |t|
      t.string :plugin_name
      t.string :version
    end
  end

  def self.down
    drop_table :plugin_schema_info
  end
end
