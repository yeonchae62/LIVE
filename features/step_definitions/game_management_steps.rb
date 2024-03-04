# frozen_string_literal: true

# features/step_definitions/game_management_steps.rb

Given('I have a game titled {string} with the url {string} and source {string}') do |title, url, source|
  Game.create!(game_title: title, url:url, source:source)
end

Given('I am on the game list page') do
  visit games_path
end

Given('I should see a {string} button') do |button_text|
  page.should have_content(button_text)
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

When('I click {string} for the game titled {string}') do |_link_text, game_title|
  # Find the div that contains the game title
  game_div = find('div#games').all('div').find { |div| div.has_text?(game_title) }

  link = game_div.find(:xpath, './following-sibling::p[1]').find('a')
  link.click
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
  visit main_page_path
end

Given(/^I am on the new game page$/) do
  visit new_game_path
end

Given(/^I am on the "([^"]*)" edit page$/) do |game_title|
  game = Game.find_by(game_title:)
  visit edit_game_path(game)
end
