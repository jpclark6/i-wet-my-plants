class AddTweetsToGardens < ActiveRecord::Migration[5.2]
  def change
    add_column :gardens, :tweet, :boolean, default: true
  end
end
