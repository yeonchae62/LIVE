Feature: Game management
  As a user
  I want to manage games

  Background:
    Given I have a game titled "Game1" with the url "http://game1.com"

  Scenario: Creating a new game
    Given I am on the game list page
    When I click "New Game"
    And I fill in "Game title" with "New Game"
    And I fill in "Url" with "http://newgame.com"
    And I click "Create Game" button
    Then I should be on the "New Game" details page

  Scenario: Viewing games
    Given I am on the game list page
    When I click "Show this game" for the game titled "Game1"
    Then I should be on the "Game1" details page

  Scenario: Updating a game
    Given I am on the "Game1" details page
    When I click "Edit this game"
    And I fill in "Game title" with "Game1 Updated"
    And I click "Update Game" button
    Then I should be on the "Game1 Updated" details page

  Scenario: Deleting a game
    Given I am on the "Game1" details page
    When I click "Destroy this game" button
    Then I should be redirected to game list page
    And I should not see "Game1" in the game list
