class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :key
      t.string :visib
      t.timestamps
    end
  end
end
