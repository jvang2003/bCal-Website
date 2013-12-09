module TableHelpers
  def update_delete_actions &block
    class_eval do
      include TableCloth::Extensions::Actions
      actions do
        action do |object|
          link_to "Update", edit_polymorphic_path(object), :class => 'btn btn-info update-status', :id => "update_#{object.id}"
        end
        action do |object|
          link_to "Delete", polymorphic_path(object), :class => 'btn btn-danger delete-status', :method => :delete, :id => "delete_#{object.id}"
        end
        yield if block_given?
      end
    end
  end
end