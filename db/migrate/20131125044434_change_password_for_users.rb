class ChangePasswordForUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
        t.string :password_digest
        t.remove :password
    end
  end

  def down
    change_table :users do |t|
        t.remove :password_digest
        t.string :password
    end
  end
end
