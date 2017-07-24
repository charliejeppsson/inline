class AddPhotoToLine < ActiveRecord::Migration[5.1]
  def change
    add_column :lines, :photo, :string
  end
end
