class BlockedTimes < ActiveRecord::Base
  attr_accessible :end_time, :start_time
  belongs_to :calendar
end
