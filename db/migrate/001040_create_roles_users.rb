class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false, :force => true do |t|
      t.integer :role_id, :limit => 11
      t.integer :user_id, :limit => 11
    end
  end

  def self.down
    drop_table :roles_users
  end
end
