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

    expect(page).to have_current_path(root_path)

    # check if role is user
    user = User.last

    expect(user.role).to eq('user')
  end
end
