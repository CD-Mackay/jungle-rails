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
  end

    # it 'contains a valid price' do
    #   @product = Product.new({price_cents: 10000})
    #   expect(@product.price_cents).to eql(10000)
    #   expect(@product.name).to be_nil
    # end
    # it 'contains a valid quantity' do
    #   @product = Product.new({quantity: 31})
    #   expect(@product.quantity).to eql(31)
    # end

    # it 'is placed in a valid category' do
    #   @product = Product.new({category_id: 1})
    #   expect(@product.category_id).to eql(1)
    
    # end
  end
end
