class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :species
      t.integer :frequency
      t.datetime :last_watered
      t.references :garden, foreign_key: true
    end
  end
end
