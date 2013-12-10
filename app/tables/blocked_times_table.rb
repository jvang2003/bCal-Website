require 'helpers'
include TableHelpers

class BlockedTimesTable < TableCloth::Base
  include TableCloth::Extensions::Actions

  column :start_time, :end_time

  class_eval do
      include TableCloth::Extensions::Actions
      actions do
        # action do |object|
        #   link_to "Update", edit_calendar_blocked_time_path(object.calendar_id, object.id), :class => 'btn btn-info update-status', :id => "update_#{object.id}"
        # end
        action do |object|
          button_to "Delete", calendar_blocked_time_path(object.calendar_id, object.id), :class => 'btn btn-danger delete-status', :method => :delete, :id => "delete_#{object.id}"
        end
      end
    end
end

