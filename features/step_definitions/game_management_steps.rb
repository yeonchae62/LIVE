# frozen_string_literal: true

# features/step_definitions/game_management_steps.rb

Given('I have a game titled {string} with the url {string} and source {string}') do |title, url, source|
  Game.create!(game_title: title, url:, source:)
end

Given('I am an admin') do
  @user = User.create!(email: 'a@a.com', password: 'password', role: 2)
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_on 'Log in'
end

Given('I am on the game list page') do
  visit games_path
end

Given('I should see a {string} button') do |button_text|
  expect(page).to have_content(button_text)
end

When('I click {string} button') do |button_text|
  click_on button_text
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I click {string}') do |link_text|
  click_on link_text
end

Then('I should be on the {string} details page') do |game_title|
  game = Game.find_by(game_title:)
  expect(page).to have_current_path(game_path(game), ignore_query: true)
end

When(/^I click the game titled "([^"]*)"$/) do |title|
  within('.games-container') do
    game_link = find('a', text: title)
    game_link.click
  end
end

Then('I should see {string} on the page') do |search_text|
  full_page_text = find('body').text
  expect(full_page_text).to include(search_text)
end

Then('I should not see {string} in the game list') do |game_title|
  expect(page).to_not have_content(game_title)
end

Then('I should be on {string} page') do |path|
  expect(page).to have_current_path(path)
end

Given('I am on the {string} details page') do |game_title|
  game = Game.find_by(game_title:)
  visit game_path(game)
end

Then('I should be redirected to game list page') do
  expect(page).to have_current_path(games_path, ignore_query: true)
end

Then('I should be redirected to home page') do
  expect(page).to have_current_path(root_path, ignore_query: true)
end

Given(/^I am on the new game page$/) do
  visit new_game_path
end

Given(/^I am on the "([^"]*)" edit page$/) do |game_title|
  game = Game.find_by(game_title:)
  visit edit_game_path(game)
end

Given('I changed my role to {string}') do |role_text|
  @user.update(role: role_text)
end

Given('I should not see {string} button') do |button_text|
  expect(page).to_not have_content(button_text)
end

And(/^there is a game with id "([^"]*)"$/) do |id|
  @game = Game.create!(id:, game_title: 'Test Game', url: 'https://example.com')
end

When('I attempt to access the edit page for game {string}') do |id|
  visit edit_game_path(id)
end

When('I attempt to update the game with id {string}') do |id|
  page.driver.submit :patch, game_path(id), { game: { game_title: 'Updated Title' } }
end

When('I attempt to delete the game with id {string}') do |id|
  page.driver.submit :delete, game_path(id), {}
end

When('I attempt to create the game with id {string}') do |_id|
  page.driver.submit :post, games_path, { game: { game_title: 'Created title' } }
end

Then('I should be shown a forbidden error') do
  expect(page).to have_content('Forbidden')
end

And('I should not be shown a {string} content') do |content_text|
  expect(page).to have_no_content(content_text)
end

And('I attempt to access new game page') do
  visit new_game_path
end
