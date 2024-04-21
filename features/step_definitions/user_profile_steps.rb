# frozen_string_literal: true

Given('I am not logged in') do
  Capybara.reset_sessions!
end

Given('I have registered with email {string} and password {string}') do |email, password|
  @user = User.create!(email:, password:)
end

Given('I am logged in as a user') do
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_on 'Log in'
end

When('I go to My Profile page') do
  visit user_account_info_path
end

When('I go to Main page') do
  visit root_path
end

When('I click on the {string} button') do |button_text|
  click_on button_text
end

Then('I should be redirected to the login page') do
  expect(page).to have_current_path(new_user_session_path, ignore_query: true)
end

Then('I should see my email is {string}') do |email|
  expect(page).to have_content("Email: #{email}")
end

And(/^I should see my role is "([^"]*)"$/) do |role|
  expect(page).to have_content("Role: #{role}")
end

And(/^I should see a link to "([^"]*)"$/) do |button_text|
  expect(page).to have_link(button_text)
end

And(/^I am on My Profile page$/) do
  visit user_account_info_path
end

And('I signed out') do
  Capybara.reset_sessions!
  visit games_path
end

And(/^I am on About Us page$/) do
  visit about_path
end

Then(/^I should be redirected to password change page$/) do
  expect(page).to have_current_path(edit_user_registration_path, ignore_query: true)
end

Then('I should see {string} button') do |button_text|
  expect(page).to have_content(button_text)
end

When('I save Games {string}') do |game_title|
  game = Game.create!(game_title:)
  @user.saved_games.create(game:)
end

And('I should see game titile of {string}') do |game_title|
  visit user_account_info_path
  expect(page).to have_content(game_title)
end
