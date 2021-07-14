class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @orders = current_user.shop.orders
  end
end
