class AddTypeToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :type, :string
  end
end
