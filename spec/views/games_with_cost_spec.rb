# spec/views/games/cost_spec.rb

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'games/cost' do
  before do
    assign(:free_games, Game.where(cost: 'Free').order(game_title: :asc))
    assign(:games_with_cost, Game.where.not(cost: 'Free').order(cost: :asc))
    assign(:games_needing_updates, Game.where(cost: nil).order(game_title: :asc))
    render
  end

  it 'displays a link to return to the main page' do
    expect(rendered).to have_link('Return to main', href: main_page_path)
  end

  it 'displays free games' do
    expect(rendered).to have_css('h2', text: 'Free Games')
    expect(rendered).to have_table('free-games')
  end

  it 'displays games with cost information' do
    expect(rendered).to have_css('h2', text: 'Games with Cost Information')
    expect(rendered).to have_table('games-with-cost')
  end

  it 'displays games needing updates' do
    expect(rendered).to have_css('h2', text: 'Games need for further updates')
    expect(rendered).to have_table('games-needing-updates')
  end
end
