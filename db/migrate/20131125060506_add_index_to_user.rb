class AddIndexToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
        t.index :role
    end
  end
end
