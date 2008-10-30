class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.references :user, :null => false
      t.integer :value, :default => 0, :null => false
    end
  end

  def self.down
    drop_table :experiences
  end
end
