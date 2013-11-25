class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :level

      t.timestamps
    end
    change_table :users do |t|
      t.remove :role
      t.integer :role_id
    end
  end
end
