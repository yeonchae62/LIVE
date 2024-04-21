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

  it 'includes a clickable link for each game that leads to its detailed view' do
    # Verify: Check that each game has a clickable link that navigates to the game's detailed view
    [game1, game2].each do |game|
      expect(page).to have_css("a[href='#{game_path(game)}']")
    end
  end

  it 'provides a link to create a new game for signed user' do
    # Verify: Check for the link to create a new game
    user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
    sign_in user
    visit games_path
    expect(page).to have_link('New Game', href: new_game_path)
  end

  it 'hide new game link for unsigned user' do
    # Verify: Check for the link to create a new game
    expect(page).to have_no_link('New Game', href: new_game_path)
  end

  it 'Navigating to the new game page for signed in user' do
    user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
    sign_in user
    visit games_path
    click_on 'New Game'

    # Verify: Ensure we're on the new game creation page
    expect(page).to have_current_path(new_game_path)
    expect(page).to have_content('New Game')
  end

  it 'Navigating to the new game page for unsigned in user' do
    user = User.create!(email: 'test2@example.com', password: 'password1234', role: 2)
    sign_out user
    visit new_game_path

    expect(page).to have_content('Forbidden')
  end
end
