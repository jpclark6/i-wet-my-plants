class CreateWaterings < ActiveRecord::Migration[5.2]
  def change
    create_table :waterings do |t|
      t.timestamps
      t.references :plant, foreign_key: true
    end
  end
end
