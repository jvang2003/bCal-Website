class EventTable < TableCloth::Base
  # To include actions on this table, uncomment this line
  # include TableCloth::Extensions::Actions

  column :summary
  %w(start end).each do |method_name|
    column method_name do |event|
      if event.send(method_name).nil?
        ""
      else
        event.send(method_name).date_time.to_s
      end
    end
  end
  column :number_of_attendees do |event|
    event.attendees.length
  end

end
