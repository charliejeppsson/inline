class AddUserToLines < ActiveRecord::Migration[5.1]
  def change
    add_reference :lines, :user, foreign_key: true
  end
end
