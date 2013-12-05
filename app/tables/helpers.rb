module TableHelpers
  def update_delete_actions
    class_eval do
      actions do
        action do |object|
          link_to "Update", edit_polymorphic_path(object), :class => 'btn btn-info update-status', :id => "update_#{object.id}"
        end
        action do |object|
          link_to "Delete", polymorphic_path(object), :class => 'btn btn-danger delete-status', :method => :delete, :id => "delete_#{object.id}"
        end
      end
    end
  end
end