class AddCalendarRequestRelationship < ActiveRecord::Migration
  def up
  	change_table :requests do |t|
  		t.integer :calendar_id
  	end
  end

  def down
  	change_table :requests do |t|
  		t.remove :calendar_id
  	end
  end
end
