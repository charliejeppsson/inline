class AddBooleanToLine < ActiveRecord::Migration[5.1]
  def change
    add_column :lines, :line_full, :boolean
  end
end
