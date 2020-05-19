class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :capacity
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.integer :min_pets

      t.timestamps
    end
  end
end
