require 'rails_helper'

RSpec.feature "Games", type: :feature do
  scenario "Visiting the games index page" do
    # Setup: Create a couple of games to display
    Game.create!(game_title: "Game1", url: "http://game1.com")
    Game.create!(game_title: "Game2", url: "http://game2.com")

    # Visit the games index page
    visit games_path

    # Verify: Check that the "Games" header is present
    expect(page).to have_content("Games")

    # Verify: Check that the names of the games are present
    expect(page).to have_content("Game1")
    expect(page).to have_content("Game2")

    # Verify: Check that each game has a "Show this game" link
    Game.all.each do |game|
      expect(page).to have_link("Show this game", href: game_path(game))
    end

    # Verify: Check for the link to create a new game
    expect(page).to have_link("New Game", href: new_game_path)
  end

  scenario "Navigating to the new game page" do
    visit games_path
    click_link "New Game"

    # Verify: Ensure we're on the new game creation page
    expect(page).to have_current_path(new_game_path)
    expect(page).to have_content("New Game")
  end
end
