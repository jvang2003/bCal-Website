class AddDetailsToRequest < ActiveRecord::Migration
  def change
      add_column :requests, :course_related, :string
      add_column :requests, :accept_different_room, :string
      add_column :requests, :department, :string
  end
end
