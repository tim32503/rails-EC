class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.references :user
      t.string :title
      t.string :cover
      t.string :description

      t.timestamps
    end
  end
end
