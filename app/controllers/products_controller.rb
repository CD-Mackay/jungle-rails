class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    puts session[:user_id]
  end

  def show
    @product = Product.find params[:id]
  end

end
