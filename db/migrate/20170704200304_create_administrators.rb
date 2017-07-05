class CreateAdministrators < ActiveRecord::Migration[5.1]
  def change
    create_table :administrators do |t|
      t.references :user, foreign_key: true
      t.references :line, foreign_key: true

      t.timestamps
    end
  end
end
