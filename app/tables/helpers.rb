module TableHelpers
  def common_actions &block
    class_eval do
      include TableCloth::Extensions::Actions
      actions do
        yield if block_given?
        action do |object|
          content_tag :div, :class => 'button-fix' do
            link_to "Update", edit_polymorphic_path(object), :class => 'btn btn-info update-status', :id => "update_#{object.id}"
          end
        end
        action do |object|
          button_to "Delete", object, :method => :delete, :class => 'btn btn-danger delete-status', :id => "delete_#{object.id}", :remote => true
        end
      end
    end
  end
end