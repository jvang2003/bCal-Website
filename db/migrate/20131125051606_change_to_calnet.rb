class ChangeToCalnet < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :password_digest
      t.remove :email

      t.string :calnet_id

      t.remove :role_id
      t.integer :role
    end

    drop_table :roles
  end
end
