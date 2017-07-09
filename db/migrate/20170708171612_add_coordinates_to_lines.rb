class AddCoordinatesToLines < ActiveRecord::Migration[5.1]
  def change
    add_column :lines, :latitude, :float
    add_column :lines, :longitude, :float
  end
end
