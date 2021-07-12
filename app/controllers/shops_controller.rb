class ShopsController < ApplicationController
  def edit
    @shop = current_user.shop
  end

  def update
    @shop = current_user.shop

    if @shop.update(shop_params)
      redirect_to edit_shop_path, notice: "賣場資料更新成功！"
    else
      render :edit
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:title, :description, :cover)
  end
end
