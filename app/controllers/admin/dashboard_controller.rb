class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: "Jungle", password: "book"
  def show
    @products = Product.find_by_sql("SELECT * FROM products")
    @categories = Category.find_by_sql("SELECT * FROM categories")
  end
end
