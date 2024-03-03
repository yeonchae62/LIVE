# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games' do
  let!(:game1) { Game.create!(game_title: 'Game1', url: 'http://game1.com') }
  let!(:game2) { Game.create!(game_title: 'Game2', url: 'http://game2.com') }

  before do
    visit games_path
  end

  it 'shows the "Games" header' do
    # Verify: Check that the "Games" header is present
    expect(page).to have_content('Games')
  end

  it 'shows the "Return to main" button' do
    expect(page).to have_content('Return to main')
    expect(page).to have_link('Return to main', href: main_page_path)
  end

  it 'displays the names of the games' do
    # Verify: Check that the names of the games are present
    expect(page).to have_content('Game1')
    expect(page).to have_content('Game2')
  end

  it 'includes a "Show this game" link for each game' do
    # Verify: Check that each game has a "Show this game" link
    [game1, game2].each do |game|
      expect(page).to have_link('Show this game', href: game_path(game))
    end
  end

  it 'provides a link to create a new game' do
    # Verify: Check for the link to create a new game
    expect(page).to have_link('New Game', href: new_game_path)
  end

  it 'Navigating to the new game page' do
    visit games_path
    click_on 'New Game'

    # Verify: Ensure we're on the new game creation page
    expect(page).to have_current_path(new_game_path)
    expect(page).to have_content('New Game')
  end
end
