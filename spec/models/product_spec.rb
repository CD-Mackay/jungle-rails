require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validation' do
    it 'saves a product with all attributes present' do
      @electronics = Category.new
      @product = Product.new(name: "test-product", 
                             category: @electronics,
                             price_cents: 40, 
                             description: "described", 
                             quantity: 100)

      @product.save!
    end

    it 'rejects a product with no name' do
      @electronics = Category.new
      @product = Product.new(category: @electronics,
                            price_cents: 50,
                            description: "descriptive",
                            quantity: 105)
      expect(@product).to_not be_valid;
      expect(@product.errors.full_messages).to include("Name can't be blank")
  end

    it 'Rejects products without a valid price' do
    @electronics = Category.new
    @product = Product.new(category: @electronics,
                          name: "Product",
                          description: "descriptive",
                          quantity: 105)
    expect(@product).to_not be_valid;
    expect(@product.errors.full_messages).to include("Price can't be blank")

    end

    it 'rejects products without a quantity' do
    @electronics = Category.new
      @product = Product.new(category: @electronics,
                            price_cents: 50,
                            description: "descriptive",
                            name: "productname")
      expect(@product).to_not be_valid;
      expect(@product.errors.full_messages).to include("Quantity can't be blank")

    end

    it 'rejects products without a category' do
    @product = Product.new(name: "Product",
                          price_cents: 50,
                          description: "descriptive",
                          quantity: 105)
    expect(@product).to_not be_valid;
    expect(@product.errors.full_messages).to include("Category can't be blank")

    end
  end
end
