require 'helpers'

class RequestTable < TableCloth::Base
  # To include actions on this table, uncomment this line
  include TableCloth::Extensions::Actions

  column :place, :people, :reason, :time, :finish_time, :status

  RequestTable::CSS_MAPPING = {
    :approved => "success",
    :pending  => "info",
    :rejected => "danger",
  }

  column :status do |request|
    content_tag :span, request.status, :class => 'big-label label label-' + RequestTable::CSS_MAPPING[request.status.to_sym]
  end


  common_actions do
    actions do
      action do |request|
        link_to "Approve", edit_request_path(request, :status => :approved), :class => 'btn btn-success', :id => "approve_#{request.id}"
      end
      action do |request|
        link_to "Reject", edit_request_path(request, :status => :rejected), :class => 'btn btn-warning', :id => "reject_#{request.id}"
      end
    end
  end
end
