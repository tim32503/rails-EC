class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :product
      t.references :shop
      t.string :name

      t.timestamps
    end
  end
end
