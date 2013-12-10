require 'helpers'
include TableHelpers

class RequestTable < TableCloth::Base
  # To include actions on this table, uncomment this line
  include TableCloth::Extensions::Actions

  column :place do |request|
    link_to(request.place.try(:name), request.place)
  end

  column :people, :reason, :status

  CSS_MAPPING = {
    :approved => "success",
    :pending  => "info",
    :rejected => "danger",
  }

  %w(start_time finish_time).each do |method_name|
    column method_name do |request|
      content_tag request.send(method_name).in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %I:%M%p")
    end
  end

  column :status do |request|
    content_tag :span, request.status, :class => 'big-label label label-' + RequestTable::CSS_MAPPING[request.status.downcase.to_sym]
  end

  common_actions do
    actions do
      [["Approve", :Approved, 'btn-success'], ["Reject", :Rejected, 'btn-warning']].each do |title, value, klass|
        action do |request|
          content_tag :div, :class => 'button-fix' do
            button_to title, request_path(request, "request[status]" => value), :method => :put, :class => 'btn ' + klass, :id => "#{title.downcase}_#{request.id}", :remote => true
          end
        end
      end
    end
  end
end
