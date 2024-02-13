# spec/acceptance/index_spec.rb

require 'rails_helper'

RSpec.feature "Main Page", type: :feature do
  scenario "User visits the main page" do
    # Visit the main page
    visit root_path

    # Assert that the header content is rendered correctly
    expect(page).to have_content("Welcome to LIVE Lab")
    expect(page).to have_content("You can enjoy searching for video games you might need using our cloud-based database services")
    expect(page).to have_link("Get Started")
    expect(page).to have_link("Learn More")

    # Assert that navigation links are present
    expect(page).to have_link("Home", href: root_path)
    expect(page).to have_link("My Info", href: my_info_path)
    expect(page).to have_link("Categories", href: categories_path)
    expect(page).to have_link("FAQ", href: faq_path)

    # Assert that the search form is present
    expect(page).to have_selector("form.form-inline")

    # Assert that featured categories are displayed
    expect(page).to have_content("What is currently being viewed the most?")
    expect(page).to have_selector(".card")
    
    # Assert that the footer content is rendered correctly
    expect(page).to have_content("Copyright &copy; Your Website 2023")
    expect(page).to have_link("Privacy")
    expect(page).to have_link("Terms")
    expect(page).to have_link("Contact")
  end
end
