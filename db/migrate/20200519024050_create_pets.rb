class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :dp_url
      t.string :species
      t.date :birthday
      t.text :bio

      t.timestamps
    end
  end
end
