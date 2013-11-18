class AddUsageToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :usage, :string
  end
end
