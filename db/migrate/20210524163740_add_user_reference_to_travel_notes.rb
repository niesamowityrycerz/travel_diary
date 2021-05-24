class AddUserReferenceToTravelNotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :travel_notes, :travaler, foreign_key: { to_table: :users }
  end
end
