class CreateLoggedExceptions < ActiveRecord::Migration
  def self.up
    create_table :logged_exceptions do |t|
      t.string :exception_class, :controller_name, :action_name, :ip_address
      t.text :message, :backtrace, :environment, :request
      t.timestamps
    end
  end

  def self.down
    drop_table :logged_exceptions
  end
end
