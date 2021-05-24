class CreateTravelNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :travel_notes do |t|
      t.text :body
      t.string :city
      t.float :current_temperature

      t.timestamps
    end
  end
end
