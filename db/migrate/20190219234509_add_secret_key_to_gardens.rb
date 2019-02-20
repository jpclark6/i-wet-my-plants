class AddSecretKeyToGardens < ActiveRecord::Migration[5.2]
  def change
    add_column :gardens, :secret_key, :string, default: nil
  end
end
