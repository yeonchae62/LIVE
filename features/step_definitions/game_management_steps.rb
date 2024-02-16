# frozen_string_literal: true

# features/step_definitions/game_management_steps.rb

Given('I have a game titled {string} with the url {string}') do |title, url|
  Game.create!(game_title: title, url:)
end

Given('I am on the game list page') do
  visit games_path
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
