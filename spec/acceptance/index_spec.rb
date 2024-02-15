# spec/acceptance/index_spec.rb
require 'rails_helper'

RSpec.feature "Main Page", type: :feature do
  scenario "User visits the main page" do
    # Visit the main page
    visit root_path
    # Assert that the header content is rendered correctly
    expect(page).to have_content("Live Lab")
    expect(page).to have_content("Welcome to Our Website")
    expect(page).to have_content("This is a project of educational video games for LIVE Lab")

    expect(page).to have_field("Search...") # Assuming the search input field has placeholder text "Search..."
    expect(page).to have_button("Search") # Assuming the search button has text "Search"

    # Assert that navigation links are present
    expect(page).to have_link("Log In", href: login_path)
    expect(page).to have_link("View All Games", href: "/games")

    # Assert that featured categories are displayed
    expect(page).to have_content("Most Watched - Category 1")
    expect(page).to have_content("Most Watched - Category 2")
    expect(page).to have_content("Most Watched - Category 3")
    expect(page).to have_content("Most Watched - Category 4")
    expect(page).to have_content("Most Watched - Category 5")
    expect(page).to have_content("Most Watched - Category 6")
    # Assert that the footer content is rendered correctly
  end
end