class AddDescriptionToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :description, :string
    remove_column :products, :quantity
  end
end
