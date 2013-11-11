class AddDeptToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :dept, :string
  end
end
