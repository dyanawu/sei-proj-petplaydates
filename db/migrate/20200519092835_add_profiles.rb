class AddProfiles < ActiveRecord::Migration[6.0]
  def change
      create_table :profiles do |t|
      t.references :user
      t.string :dp_url
      t.text :bio
      t.string :location
      t.string :gender
      t.date :birthday
    end
  end
end
