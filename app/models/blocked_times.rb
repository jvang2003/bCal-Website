class BlockedTimes < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :calendar_id
  belongs_to :calendar

  %w(start_time, end_time).each do |method_name|
    define_method "#{method_name}_div" do
      content_tag block.send(method_name).in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M%p")
    end
  end
end
