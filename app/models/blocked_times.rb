class BlockedTimes < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :calendar_id
  belongs_to :calendar
end
