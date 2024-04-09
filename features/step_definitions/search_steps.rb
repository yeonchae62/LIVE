# frozen_string_literal: true

Given('I have a game titled {string} with the dimensions {string} and source {string}') do |title, dimensions, source|
  Game.create!(game_title: title, dimensions:, source:)
end

Given('I am on the homepage') do
  visit root_path
end

When('I do not enter any search criteria') do
  click_on 'Search'
end

Then('I should see all games') do
  expect(page).to have_css('.game', count: Game.count)
end

When('I search for {string}') do |search_term|
  fill_in 'search', with: search_term
  click_on 'Search'
end

Then('I should see a game titled {string}') do |title|
  expect(page).to have_content(title)
end

Then('I should not see a game titled {string}') do |title|
  expect(page).to have_no_content(title)
end

Then('I should see {string} on the top of the game list') do |game_title|
  first_game_in_list = page.find_all('.games-container').first
  expect(first_game_in_list).to have_content(game_title)
end

And('I should see {string} on the bottom of the game list') do |game_title|
  last_game_in_list = page.find_all('.games-container').last
  expect(last_game_in_list).to have_content(game_title)
end

Then('I should be redirected to the game list page') do
  expect(page).to have_current_path(games_path, ignore_query: true)
end

Then(/^I should see a message saying "([^"]*)"$/) do |msg|
  expect(page).to have_text(msg)
end

When(/^I press the "([^"]*)" button without entering any search text$/) do |arg|
  click_on arg
end
