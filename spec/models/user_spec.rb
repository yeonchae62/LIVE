# spec/features/user_registration_spec.rb

require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do
  scenario 'User creates an account' do
    visit new_user_registration_path

    fill_in 'user_email', with: 'r_test@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    click_button 'Sign up'

    # Add expectations based on your application's behavior
    expect(page).to have_content('Welcome to Our Website')
  end
end
