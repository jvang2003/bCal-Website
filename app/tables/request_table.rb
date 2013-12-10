require 'helpers'
include TableHelpers

class RequestTable < TableCloth::Base
  # To include actions on this table, uncomment this line
  include TableCloth::Extensions::Actions

  column :place, :people, :reason, :start_time, :finish_time, :status

  RequestTable::CSS_MAPPING = {
    :approved => "success",
    :pending  => "info",
    :rejected => "danger",
  }

  column :start_time do |request|
    content_tag request.start_time.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M%p")
  end

  column :finish_time do |request|
    content_tag request.finish_time.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M%p")
  end

  column :status do |request|
    content_tag :span, request.status, :class => 'big-label label label-' + RequestTable::CSS_MAPPING[request.status.downcase.to_sym]
  end


  common_actions do
    actions do
      action do |request|
        content_tag :div, :class => 'button-fix' do
          button_to "Approve", request_path(request, :status => :Approved), :method => :put, :class => 'btn btn-success', :id => "approve_#{request.id}"
        end
      end
      action do |request|
        content_tag :div, :class => 'button-fix' do
          button_to "Reject", request_path(request, :status => :Rejected), :method => :put, :class => 'btn btn-warning', :id => "reject_#{request.id}"
        end
      end
    end
  end
end
