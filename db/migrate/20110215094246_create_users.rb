class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users" do |t|
      t.string    :username
      t.string    :email     
      t.string    :crypted_password
      t.string    :password_salt    
      t.string    :persistence_token

    end
    add_index :users, :username, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
