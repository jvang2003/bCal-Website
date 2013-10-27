class AddDisabledToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :disabled, :boolean
  end
end
