require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  scenario "The user logs in succesfully" do
    user = User.create(
      first_name: "Frank",
      last_name: "Reynolds",
      email: "frank@reynolds.com",
      password: "charlie",
      password_confirmation: "charlie"
    )
    visit root_path
    user.save!
    expect(page).to have_text("Login")
    page.find("a", :text => /Login/).click
    sleep(1)
    save_screenshot 'loginpage?.png'
    page.fill_in 'email', with: "frank@reynolds.com"
    page.fill_in 'password', with: "charlie"
    click_button("Login")
    sleep(1)
    save_screenshot 'after_login.png'
    expect(page).to have_text("Logout")

  end

  
end
