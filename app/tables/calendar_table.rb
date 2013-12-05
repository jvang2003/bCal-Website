require 'helpers.rb'
include TableHelpers

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

  update_delete_actions
end
