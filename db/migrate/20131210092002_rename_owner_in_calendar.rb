class RenameOwnerInCalendar < ActiveRecord::Migration
    def change
        change_table :calendars do |t|
            t.rename :owner, :owner_id
        end
    end
end
