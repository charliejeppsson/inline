class AddLineToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_reference :appointments, :line, foreign_key: true
  end
end
