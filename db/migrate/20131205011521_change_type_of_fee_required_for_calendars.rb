class ChangeTypeOfFeeRequiredForCalendars < ActiveRecord::Migration
 def up
   change_column :calendars, :fee_required, :boolean
   Calendar.all.each do |cal|
     cal.fee_required = cal.fee_required == "0" ? false : true
     cal.save
   end
  end

  def down
   change_column :calendars, :fee_required, :string
   Calendar.all.each do |cal|
     cal.fee_required = cal.fee_required == false ? "0" : "1"
     cal.save
   end
  end
end
