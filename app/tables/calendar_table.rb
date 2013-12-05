class CalendarTable < TableCloth::Base
  # Define columns with the #column method
  include TableCloth::Extensions::Actions

  column :name do |calendar|
    link_to calendar.name, calendar_path(calendar), :class => :name
  end

  column :email, :visibility

  %w(fee_required disabled).each do |field|
    column field do |calendar|
      calendar.send(field) ? "Yes" : "No"
    end
  end

  column :building, :usage

  actions do
    action do |calendar|
      link_to "Update", edit_calendar_path(calendar), :class => 'btn btn-info update-status'
    end
    action do |calendar|
      link_to "Delete", calendar_path(calendar), :class => 'btn btn-danger update-status', :method => :delete
    end
  end
end
