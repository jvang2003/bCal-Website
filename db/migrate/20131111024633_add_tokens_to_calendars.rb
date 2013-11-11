class AddTokensToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :access_token, :string
    add_column :calendars, :refresh_token, :string
  end
end
