class AddApprovedFlag < ActiveRecord::Migration
  def up
  	change_table :requests do |t|
  		t.boolean :approved
  	end
  end

  def down
  	change_table :requests do |t|
  		t.remove :approved
  	end
  end
end
