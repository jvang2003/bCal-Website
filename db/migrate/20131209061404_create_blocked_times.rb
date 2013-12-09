class CreateBlockedTimes < ActiveRecord::Migration
  def change
    create_table :blocked_times do |t|
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
