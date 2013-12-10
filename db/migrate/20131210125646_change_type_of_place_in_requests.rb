class ChangeTypeOfPlaceInRequests < ActiveRecord::Migration
    def change
        change_table :requests do |t|
            t.remove :place
            t.integer :place_id
        end
    end
end
