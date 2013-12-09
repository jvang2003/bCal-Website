class AddOwnerToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :owner, :string
  end
end
