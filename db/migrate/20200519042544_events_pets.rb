class EventsPets < ActiveRecord::Migration[6.0]
  def change
    create_table :events_pets do |t|
      t.references :event
      t.references :pet
      t.timestamps
    end
  end
end
