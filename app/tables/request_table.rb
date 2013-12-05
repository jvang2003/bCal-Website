class RequestTable < TableCloth::Base
  # To include actions on this table, uncomment this line
  include TableCloth::Extensions::Actions

  column :place, :people, :reason, :time, :status

  actions do
    action {|request| link_to "Update", edit_request_path(request), :class => "btn btn-info update-status" }
  end

end
