class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries, :force => true do |t|
      t.string  :name,        :limit => 100, :default => "",    :null => false
      t.string  :code,        :limit => 50
      t.integer :rank,        :limit => 11
      t.boolean :is_obsolete,                :default => false, :null => false
    end
  end

  def self.down
    drop_table :countries
  end
end
