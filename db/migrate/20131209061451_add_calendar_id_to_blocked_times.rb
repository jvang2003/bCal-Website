class AddCalendarIdToBlockedTimes < ActiveRecord::Migration
  def change
    change_table :blocked_times do |t|
      t.integer :calendar_id
    end
  end
end
