# frozen_string_literal: true

# spec/features/main_page_spec.rb
require 'rails_helper'

RSpec.describe 'MainPage' do
  it 'User visits the main page' do
    visit root_path

    expect(page).to have_content('Live Lab')
    expect(page).to have_content('Welcome to Our Website')
    expect(page).to have_link('Log In', href: login_path)
    expect(page).to have_content('This is a project of educational video games for LIVE Lab')
    expect(page).to have_field(placeholder: 'Search...')
    expect(page).to have_button('Search')

    # expect(page).to have_css('.image-container', count: 6)
    expect(page).to have_link('View All Games', href: '/games')
  end
end
