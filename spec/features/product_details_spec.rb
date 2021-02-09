require 'rails_helper'

RSpec.feature "User navigates to ", type: :feature, js: true do
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
  scenario "The user views the page for the selected product" do
    visit root_path
    button = page.find('.products').first('#product_name').click
    sleep(1)
    save_screenshot 'product_page.png'
    expect(page).to have_css('.product-detail')
  end


end
