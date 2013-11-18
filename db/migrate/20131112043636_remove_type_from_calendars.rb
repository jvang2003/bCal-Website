class RemoveTypeFromCalendars < ActiveRecord::Migration
  def up
    remove_column :calendars, :type
  end

  def down
    add_column :calendars, :type, :string
  end
end
