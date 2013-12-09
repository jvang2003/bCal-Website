class AddFinishTimeToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :finish_time, :datetime
  end
end
