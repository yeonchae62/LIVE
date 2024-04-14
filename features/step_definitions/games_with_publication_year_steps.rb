# frozen_string_literal: true

Given('I am on the games with publication-year page') do
  visit games_with_publication_year_path
end

Then('I should see a link to return to the main page from games with publication year') do
  expect(page).to have_link('Return to main', href: main_page_path)
end

Then('I should see a list of latest games') do
  expect(page).to have_css('h2', text: 'Latest Games')
  expect(page).to have_table('latest-games')
  games = Game.where.not(publication_year: nil)
              .select { |game| game.publication_year.to_s.match?(/\d/) && game.publication_year.to_s.length != 4 }
  games.each do |game|
    expect(page).to have_content(game.publication_year.presence || 'info not included')
  end
end

Then('I should see a list of game needed to be checked') do
  expect(page).to have_css('h2', text: 'Publication Year - Needed to be Checked')
  expect(page).to have_table('games-tobechecked')
  games = Game.where.not(publication_year: nil)
              .select { |game| game.publication_year.to_s.match?(/\d/) && game.publication_year.to_s.length != 4 }
  games.each do |game|
    expect(page).to have_content(game.publication_year.presence || 'info not included')
  end
end

Then('I should see a list of latest game needed to further updates') do
  expect(page).to have_css('h2', text: 'Games need for further updates')
  expect(page).to have_table('games-with-updates')
  games = Game.where(publication_year: [nil, 'UC']).order(game_title: :asc, publication_year: :asc)
  games.each do |game|
    expect(page).to have_content(game.publication_year.presence || 'info not included')
  end
end
