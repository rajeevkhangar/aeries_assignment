class ProductsController < ApplicationController

  def index
    render json: { products: Product.all, each_serializer: ProductSerializer }
  end

  def show
    product = Product.find params[:id]
    render json: product
  end
end
