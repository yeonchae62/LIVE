Feature: Save game functionality
  As a logged-in user
  I want to be able to save a game
  So that I can access it later

  Scenario: Save a game from the games index page
    Given I am logged in to save a game
    When I visit the games index page to save a game
    And I click on the Save button for game "Test Game"
    Then I should see a success message "Game saved successfully!"
    And I should see the game "Test Game" in my saved games list
