# frozen_string_literal: true

Given('I have a game {string} with the image_url {string}') do |game_title, image_url|
  # Create a game with the given title and image_url
  Game.create!(game_title:, image: image_url)
end

Given('I have a game {string} without an image') do |game_title|
  # Create a game with the given title and no image_url
  Game.create!(game_title:)
end

When('I visit the game information page for {string}') do |game_title|
  # Visit the page that shows the information of the specified game
  game = Game.find_by(game_title:)
  visit game_path(game)
end

Then('I should see an image for the game') do
  # Verify that an image is present for the game
  expect(page).to have_css('img')
end

Then('I should not see an image for the game') do
  # Verify that no image is present for the game
  expect(page).to have_css('img')
end
