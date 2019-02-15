class AddsTwitterHandletoGarden < ActiveRecord::Migration[5.2]
  def change
    add_column :gardens, :twitter_handle, :string
  end
end
