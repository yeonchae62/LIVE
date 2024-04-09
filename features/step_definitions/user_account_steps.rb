# frozen_string_literal: true

# features/step_definitions/create_user_account_steps.rb

Given('I am on the sign up page') do
  visit new_user_registration_path
end

When('I write in {string} with {string}') do |field, value|
  fill_in field, with: value
end

And('I press {string}') do |button|
  click_on button
end

Then('I shall see {string}') do |content|
  expect(page).to have_content(content)
end

Given('I am on the registration page') do
  visit new_user_registration_path
end

When('I fill in the registration form with valid data') do
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
end

And('I submit the registration form') do
  click_on 'Sign up'
end

Then('I should see a successful registration message') do
  expect(page).to have_content('Welcome! You have signed up successfully.')
end

And('the user should have the default role') do
  user = User.last # Assuming the last created user is the one we just registered
  expect(user.role).to eq('user')
end

# Password Reset
Given('I have a registered account') do
  @user = User.create(email: 'test@example.com', password: 'password123')
end

And('I am on the forgot password page') do
  visit new_user_password_path
end

When('I fill in my email address') do
  fill_in 'Email', with: 'test@example.com'
end

Then('I should receive an email with reset password instructions') do
  expect(ActionMailer::Base.deliveries.last.to).to eq(['test@example.com'])
  expect(ActionMailer::Base.deliveries.last.subject).to eq('Reset password instructions')
end

# step_definitions/user_steps.rb

Given('a new user is created') do
  @user = User.new(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
end

Then("the user's role should be user") do
  expect(@user.role).to eq('user') # Assuming the default role is 'user'
end
