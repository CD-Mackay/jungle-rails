require 'rails_helper'

RSpec.feature "Adding products to shopping cart", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
    @category.products.create!(
      name: Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
    end
  end

  scenario "The user adds an item to the shopping cart" do
    visit root_path
    cart = page.find_link('My Cart')
    page.find('.products').first('.button_to').click
    sleep(1)
    save_screenshot 'add-to-cart.png'

  end

end