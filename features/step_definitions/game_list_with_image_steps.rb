# frozen_string_literal: true

Given('there are games with images') do
  # Create games with images
  Game.create!(game_title: 'Game1', url: 'http://example.com', image: 'http://example.com/image1.jpg')
  Game.create!(game_title: 'Game2', url: 'http://example.com', image: 'http://example.com/image2.jpg')
end

Given('there are games without images') do
  # Create games without images
  Game.create!(game_title: 'Game3', url: 'http://example.com')
  Game.create!(game_title: 'Game4', url: 'http://example.com')
end

When('I visit the games list page') do
  visit games_path
end

Then('I should see game information with images') do
  # Verify that game information with images is displayed
  expect(page).to have_css('.game .game-info .game-image')
end

Then('I should see game information without images') do
  # Verify that game information without images is displayed
  expect(page).to have_css('.game .game-info .game-image')
end
