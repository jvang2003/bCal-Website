class AddEventInfo < ActiveRecord::Migration
  def up
  	change_table :events do |t|
  	  t.integer :request_id
  	  t.string :google_cal_id
  	end
  end

  def down
  	change_table :events do |t|
  	  t.remove :request_id, :google_cal_id
  	end
  end
end
