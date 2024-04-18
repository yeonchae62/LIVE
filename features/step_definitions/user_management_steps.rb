# frozen_string_literal: true

# features/step_definitions/user_management_steps.rb

Given('there are existing users') do
  @user1 = User.create(email: 'test1@example.com', password: 'password123', role: 1)
  @user2 = User.create(email: 'test2@example.com', password: 'password123', role: 0)
  @user3 = User.create(email: 'test3@example.com', password: 'password123', role: 0)
end

When('I visit the user management page') do
  visit user_management_path
end

Then('I should see a list of all users') do
  User.find_each do |user|
    expect(page).to have_content(user.email)
  end
end

When('I change the role of a user to admin') do
  @user1.update(role: 'admin')
end

Then('I should see user role as admin') do
  @user1.reload
  expect(@user1.role).to eq('admin')
end

Given('I am logged in as an admin') do
  User.create(email: 'admin@example.com', password: 'password123', role: 2)
  visit new_user_session_path
  fill_in 'Email', with: 'admin@example.com'
  fill_in 'Password', with: 'password123'
  click_on 'Log in'
end

Given('there is a user with the email {string} and role {string}') do |email, role|
  User.create!(email:, password: 'password', role:)
end

When('I change the role of {string} to {string}') do |email, new_role|
  within(:xpath, "//tr[td[contains(text(), '#{email}')]]") do
    select new_role, from: 'role'
    click_on 'Change Role'
  end
end

Then('I should see a notice {string}') do |notice|
  expect(page).to have_content(notice)
end

And('the user {string} should have the role {string}') do |email, role|
  user = User.find_by(email:)
  expect(user.role).to eq role
end

When(/^I attempt to access the user management page$/) do
  visit user_management_path
end

And('I should see an alert {string}') do |message|
  expect(page).to have_text(message, wait: 5)
end

Given(/^I am logged in as a regular user$/) do
  user = User.create!(email: 'regularuser@example.com', password: 'password')
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_on 'Log in'
end
