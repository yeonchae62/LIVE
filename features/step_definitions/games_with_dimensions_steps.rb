# features/step_definitions/games_with_cost_steps.rb

# frozen_string_literal: true

Given('I am on the games with dimensions page') do
  visit games_with_dimensions_path
end

Then('I should see a link to return to the main page from games with dimensions') do
  expect(page).to have_link('Return to main', href: main_page_path)
end

Then('I should see a list of 3D games') do
  expect(page).to have_css('h2', text: 'All Games with 3D Contents')
  expect(page).to have_table('3D-games')
  games = Game.where(dimensions: ['3D']).order(dimensions: :desc)
  games.each do |game|
    expect(page).to have_content(game.dimensions.presence || 'info not included')
  end
end

Then('I should see a list of 2D games') do
  expect(page).to have_css('h2', text: 'All Games with 2D Contents')
  expect(page).to have_table('2D-games')
  games = Game.where(dimensions: ['2D']).order(dimensions: :asc)
  games.each do |game|
    expect(page).to have_content(game.dimensions.presence || 'info not included')
  end
end

Then('I should see a list of games needing further updates on the games with dimensions page') do
  expect(page).to have_css('h2', text: 'All Games Needed Further Information')
  expect(page).to have_table('other-games')
  games = Game.where(dimensions: [nil]).order(game_title: :asc)
  games.each do |game|
    expect(page).to have_content(game.dimensions.presence || 'info not included')
  end
  games = Game.where.not(dimensions: %w[2D 3D]).order(dimensions: :asc)
  games.each do |game|
    expect(page).to have_content(game.dimensions.presence || 'info not included')
  end
end
