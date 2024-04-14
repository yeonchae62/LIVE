# features/step_definitions/games_with_cost_steps.rb

# frozen_string_literal: true

Given('I am on the games with cost page') do
  visit games_with_cost_path
end

Then('I should see a link to return to the main page from games with cost') do
  expect(page).to have_link('Return to main', href: main_page_path)
end

Then('I should see a list of free games') do
  expect(page).to have_css('h2', text: 'Free Games')
  expect(page).to have_table('free-games')
  games = Game.where(cost: 'Free').order(game_title: :asc)
  games.each do |game|
    expect(page).to have_content(game.cost.presence || 'info not included')
  end
end

Then('I should see a list of games with cost information on the games') do
  expect(page).to have_css('h2', text: 'Games with Cost Information')
  expect(page).to have_table('games-with-cost')
  games = Game.where.not(cost: 'Free').order(cost: :asc)
  games.each do |game|
    expect(page).to have_content(game.cost.presence || 'info not included')
  end
end

Then('I should see a list of games needing further updates on the games with cost page') do
  expect(page).to have_css('h2', text: 'Free Games')
  expect(page).to have_table('games-needing-updates')
  games = Game.where(cost: [nil]).order(game_title: :asc)
  games.each do |game|
    expect(page).to have_content(game.cost.presence || 'info not included')
  end
end
