# frozen_string_literal: true

Given('I have the following games:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |game_attributes|
    Game.create!(
      game_title: game_attributes['title'],
      dimensions: game_attributes['dimensions'],
      source: game_attributes['source'],
      publication_year: game_attributes['publication year'],
      cost_value: game_attributes['cost_value'],
      platform: game_attributes['platform'],
      genre: game_attributes['genre'],
      subject1: game_attributes['subject1'],
      used_in_class: game_attributes['used_in_class'],
      downloadable: game_attributes['downloadable']
    )
  end
end

Given('I am on the homepage') do
  visit root_path
end

When('I do not enter any search criteria') do
  click_on 'Search'
end

Then('I should see all games') do
  expect(page).to have_css('.game_list_link', count: Game.count)
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

Given(/^I am on the search result page$/) do
  visit(root_path)
  fill_in 'search', with: 'match'
  click_on 'Search'
end

Then(/^the "([^"]*)" dropdown should be "([^"]*)"$/) do |arg1, arg2|
  # Find the dropdown by its name or another identifiable attribute
  expect(find("select[name=\"#{arg1}\"]").value).to eq(arg2)
end

Then('the search results should be sorted by game title in ascending order') do
  expect_game_titles_in_order(['Game2', 'Game3', 'Game5', 'Match Game1'])
end

When(/^I select "([^"]*)" from the "([^"]*)" dropdown$/) do |option, dropdown_name|
  select(option, from: dropdown_name)
  click_on 'Search'
end

Then(/^the search results should be sorted by publication year in descending order$/) do
  expect_game_titles_in_order(['Game3', 'Game5', 'Game2', 'Match Game1'])
end

Then(/^the search results should be sorted by lowest price first$/) do
  expect_game_titles_in_order(['Match Game1', 'Game2', 'Game3', 'Game5'])
end

Then(/^the search results should be sorted by highest price first$/) do
  expect_game_titles_in_order(['Game5', 'Game3', 'Game2', 'Match Game1'])
end

When(/^I refresh the page$/) do
  visit page.current_url
end

Then(/^my sort selection should persist$/) do
  expect(page).to have_css("select[name='sort_by'] option[selected]", text: 'Title')
end

Then('I should see the games ordered by relevance') do
  expect_game_titles_in_order(['Match Game1', 'Game2', 'Game3', 'Game5'])
end
