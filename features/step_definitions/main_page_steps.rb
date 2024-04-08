# frozen_string_literal: true

Given('I have the most_watched games') do
  fetch_most_watched_game_titles.each do |title|
    Game.find_or_create_by!(game_title: title) do |g|
      g.image = 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg'
    end
  end
end

When('I visit the main page') do
  visit root_path
end

Then('I should see {string}') do |content|
  expect(page).to have_content(content)
end

Then('I should see a link {string} leading to the login page') do |link_text|
  expect(page).to have_link(link_text, href: '/login')
end

Then('I should see a search input field with placeholder {string}') do |placeholder|
  expect(page).to have_css("input[type=\"text\"][placeholder=\"#{placeholder}\"]")
end

Then('I should see a search button') do
  expect(page).to have_button(type: 'submit')
end

Then('I should see six image containers') do
  expect(page).to have_css('.image-container', count: 6)
end

Then('I should see a link {string} leading to the games page') do |link_text|
  expect(page).to have_link(link_text, href: '/games')
end

Given('I am on the main page') do
  visit root_path
end

Given('I see a list of most watched games') do
  expect(page).to have_css('.container .image-container', wait: 10)
end

When('I click on the title of the first game') do
  first('.container .image-container a').click
end

Then('I should be redirected to the game details page') do
  expect(page).to have_current_path(game_path(Game.first))
  expect(page).to have_content(Game.first.game_title)
end

Then('I print the page HTML') do
  puts page.html # Outputs the current page HTML
end


Then('I should see a link to view games by cost') do
  expect(page).to have_link('View Games by Cost', href: cost_games_path)
end

Then('I should see a link to view latest game') do
  expect(page).to have_link('Latest Game', href: publication_year_games_path)
end

Then('I should see a link to view 3D games') do
  expect(page).to have_link('3D', href: dimensions_games_path)
end

Then(/^I should see a navigation bar$/) do
  expect(page).to have_css('.navbar')
end

And(/^I should see links to "([^"]*)", "([^"]*)", "([^"]*)"$/) do |link1, link2, link3|
  expect(page).to have_link(link1)
  expect(page).to have_link(link2)
  expect(page).to have_link(link3)
end

When(/^I click on the "([^"]*)" link in the navigation bar$/) do |arg|
  click_on arg
end

Then(/^I should be on My Profile page$/) do
  expect(page).to have_current_path(user_account_info_path, ignore_query: true)
end
