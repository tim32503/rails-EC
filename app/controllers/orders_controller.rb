class OrdersController < ApplicationController
  def index
    @orders = current_user.shop.orders
  end
end
