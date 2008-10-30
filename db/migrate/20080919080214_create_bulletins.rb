class CreateBulletins < ActiveRecord::Migration
  def self.up
    create_table :bulletins do |t|
      t.string :title, :limit => 200, :null => false
      t.text :content
      t.date :displayed_at, :null => false
      t.boolean :visible, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :bulletins
  end
end
