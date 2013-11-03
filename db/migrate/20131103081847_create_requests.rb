class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :people
      t.text :reason
      t.text :details
      t.string :place

      t.timestamps
    end
  end
end
