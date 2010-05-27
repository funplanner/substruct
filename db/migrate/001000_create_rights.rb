class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :rights, :force => true do |t|
      t.string :name
      t.string :controller
      t.string :actions
    end
  end

  def self.down
    drop_table :rights
  end
end
