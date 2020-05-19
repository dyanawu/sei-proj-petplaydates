class RemoveTimestampsFromSpecies < ActiveRecord::Migration[6.0]
  def change
    remove_column :species, :created_at, :string
    remove_column :species, :updated_at, :string
  end
end
