class CreateGardens < ActiveRecord::Migration[5.2]
  def change
    create_table :gardens do |t|
      t.string :name
      t.integer :zip_code
      t.references :user, foreign_key: true
    end
  end
end
