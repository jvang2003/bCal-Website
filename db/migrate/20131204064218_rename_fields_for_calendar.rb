class RenameFieldsForCalendar < ActiveRecord::Migration
  def up
    rename_column :calendars, :visib, :visibility
    rename_column :calendars, :dept, :department
  end

  def down
    rename_column :calendars, :visibility, :visib
    rename_column :calendars, :department, :dept
  end
end
