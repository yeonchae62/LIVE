Feature: Search Games
  As a user
  I want to search for games
  So that I can find games matching my search criteria

  Background:
    Given I have a game titled "Match Game1" with the dimensions "2D" and source "Source1"
    And I have a game titled "Game2" with the dimensions "match" and source "Source2"
    And I have a game titled "Game3" with the dimensions "3D" and source "Match3"
    And I have a game titled "Game4" with the dimensions "2D" and source "Source4"

  Scenario: Search redirects to the game list page
    Given I am on the homepage
    When I click "Search"
    Then I should be redirected to the game list page


  Scenario: Search without parameters
    Given I am on the homepage
    When I do not enter any search criteria
    Then I should see all games

  Scenario: Search with matching criteria
    Given I am on the homepage
    When I search for "Match"
    Then I should see a game titled "Match Game1"
    And I should see a game titled "Game2"
    And I should see a game titled "Game3"
    And I should not see a game titled "Game4"

  Scenario: Results are ordered by relevance
    Given I am on the homepage
    When I search for "Match"
    Then I should see "Match Game1" on the top of the game list
    And I should see "Game2" on the bottom of the game list

  Scenario: No results found for a specific search
    Given I am on the game list page
    When I search for "Nonexistent Game"
    Then I should see a message saying "No results found"

  Scenario: Search with empty input returns all games
    Given I am on the game list page
    When I press the "Search" button without entering any search text
    Then I should see a game titled "Match Game1"
    And I should see a game titled "Game2"
    And I should see a game titled "Game3"
    And I should see a game titled "Game4"
