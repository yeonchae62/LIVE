Feature: Save Game
  As a logged-in user
  I want to save games
  So that I can access them later

  Scenario: Save a game successfully
    Given I am logged in to save a game
    Given "game" is in the index page
    And I have not already saved the game "game"
    And I visit the games index page to save a game
    When I click on the Save button for the game "game"
    Then I should see that the game saved successfully!

  Scenario: Save an already saved game
    Given I am logged in to save a game
    Given "game" is in the index page
    And I have already saved the game "game"
    And I visit the games index page to save a game
    When I click on the Save button for the game "game"
    Then I should see this game is already saved
