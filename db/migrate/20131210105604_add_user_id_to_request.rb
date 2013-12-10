class AddUserIdToRequest < ActiveRecord::Migration
  def change
    change_table :requests do |t|
        t.integer :user_id
    end
  end
end
