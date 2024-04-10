# spec/views/games_with_publication_year_spec.rb

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'games/publication_year' do
  before do
    latest_games_query = Game.where.not(publication_year: nil)
                             .select do |game|
                               game.publication_year.to_s.match?(/\d/) && game.publication_year.to_s.length != 4
                             end
    assign(:latest_games, latest_games_query)
    assign(:games_to_be_checked, latest_games_query)
    assign(:games_upd, Game.where(publication_year: [nil, 'UC']).order(game_title: :asc, publication_year: :asc))
    render
  end

  it 'displays a link to return to the main page' do
    expect(rendered).to have_link('Return to main', href: main_page_path)
  end

  it 'displays latest games' do
    expect(rendered).to have_css('h2', text: 'Latest Games')
    expect(rendered).to have_table('latest-games')
  end

  it 'displays games needed to be checked' do
    expect(rendered).to have_css('h2', text: 'Publication Year - Needed to be Checked')
    expect(rendered).to have_table('games-tobechecked')
  end

  it 'displays games needing updates' do
    expect(rendered).to have_css('h2', text: 'Games need for further updates')
    expect(rendered).to have_table('games-with-updates')
  end
end
