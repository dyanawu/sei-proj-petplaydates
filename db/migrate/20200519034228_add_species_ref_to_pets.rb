class AddSpeciesRefToPets < ActiveRecord::Migration[6.0]
  def change
    remove_column :pets, :species, :string
    add_reference :pets, :species, null: false, foreign_key: true
  end
end
