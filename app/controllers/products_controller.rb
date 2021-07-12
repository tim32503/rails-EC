class ProductsController < ApplicationController
  before_action :find_products
  
  def index
  end

  def show

  end

  def new
    @product = @products.new
  end

  def create
    @product = @products.new(product_params)

    if @product.save
      redirect_to products_path, notice: "商品新增成功！"
    else
      render :new
    end
  end

  def edit
    @product = @products.find(params[:id])
  end

  def update
    @product = @products.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path, notice: "商品已更新！"
    else
      render :edit
    end
  end

  def destroy
    @product = @products.find(params[:id])
    @product.destroy if @product
    redirect_to products_path, notice: "商品已刪除！"
  end

  private

  def find_products
    @products = current_user.shop.products
  end

  def product_params
    params.require(:product).permit(:name, :cover, :price, :quantity)
  end
end
