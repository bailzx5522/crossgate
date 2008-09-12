class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :limit => 30, :null => false
      t.string :hashed_password, :limit => 32, :null => false
      t.string :screen_name, :limit => 16, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
