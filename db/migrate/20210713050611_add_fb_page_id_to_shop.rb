class AddFbPageIdToShop < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :fb_page_id, :string
  end
end
