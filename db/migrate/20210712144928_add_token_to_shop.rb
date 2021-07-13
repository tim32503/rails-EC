class AddTokenToShop < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :fb_page_access_token, :string
  end
end
