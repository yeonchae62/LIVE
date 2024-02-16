# spec/features/main_page_spec.rb
require 'rails_helper'

RSpec.feature "MainPage", type: :feature do
  scenario "User visits the main page" do
    visit root_path

    expect(page).to have_content("Live Lab")
    expect(page).to have_content("Welcome to Our Website")
    expect(page).to have_link("Log In", href: login_path)
    expect(page).to have_content("This is a project of educational video games for LIVE Lab")
    expect(page).to have_selector("input[type=text][placeholder='Search...']")
    expect(page).to have_button("Search")
    
    expect(page).to have_selector(".image-container", count: 6)
    expect(page).to have_link("View All Games", href: "/games")
  end
end
