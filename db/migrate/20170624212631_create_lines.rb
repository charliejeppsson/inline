class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.string :title
      t.string :organization_name
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.integer :avg_service_time

      t.timestamps
    end
  end
end
