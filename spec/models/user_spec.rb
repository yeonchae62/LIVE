# frozen_string_literal: true

# spec/features/user_registration_spec.rb

require 'rails_helper'

RSpec.describe 'User Registration', type: :feature do
  it 'User creates an account' do
    visit new_user_registration_path

    fill_in 'user_email', with: 'r_test@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    click_on 'Sign up'

    # Add expectations based on your application's behavior
    expect(page).to have_content('Welcome to Our Website')
  end
end
