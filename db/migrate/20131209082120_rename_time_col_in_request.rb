class RenameTimeColInRequest < ActiveRecord::Migration
	
  def change
  	rename_column :requests, :time, :start_time
  end

end
