class ChangeTypeOfFeeRequiredForCalendars < ActiveRecord::Migration
 def up
   add_column :calendars, :fee_required, :boolean, :default => false
  end

  def down
    remove_column :calendars, :fee_required
  end
end
