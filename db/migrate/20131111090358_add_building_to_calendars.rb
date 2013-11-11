class AddBuildingToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :building, :string
  end
end
