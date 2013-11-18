class RenameApiKeyToEmail < ActiveRecord::Migration
  def up
  	rename_column :calendars, :key, :email  	
  end

  def down
  	rename_column :calendars, :email, :key
  end
end
