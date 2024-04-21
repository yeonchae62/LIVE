Feature: Search and Sort Games
  As a user
  I want to search for games and sort the results
  So that I can find and organize games matching my search criteria

  Background:
    Given I have the following games:
      | title  | dimensions | source  | publication year | cost_value |
      | Match Game1  | 2D   | Source1 | 2000             | 10.0  |
      | Game2  | match      | Source2 | 2014             | 12.0  |
      | Game3  | 3D         | Match3  | 2020             | 13.0  |
      | Game4  | 2D         | Source4 | 2000             | 14.0  |
      | Game5  | match      | Source5 | 2015             | 15.0  |


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

  Scenario: Default sorting option is applied
    Given I am on the search result page
    Then the "sort_by" dropdown should be "Relevance"
    And I should see "Match Game1" on the top of the game list
    And I should see "Game2" on the bottom of the game list

  Scenario: Sorting search results by Title
    Given I am on the search result page
    When I select "Title" from the "sort_by" dropdown
    Then the search results should be sorted by game title in ascending order

  Scenario: Sorting search results by Publication Year
    Given I am on the search result page
    When I select "Publication Year" from the "sort_by" dropdown
    Then the search results should be sorted by publication year in descending order

  Scenario: Sorting search results by Lowest Price
    Given I am on the search result page
    When I select "Lowest Price" from the "sort_by" dropdown
    Then the search results should be sorted by lowest price first

  Scenario: Sorting search results by Highest Price
    Given I am on the search result page
    When I select "Highest Price" from the "sort_by" dropdown
    Then the search results should be sorted by highest price first

  Scenario: Sort selection persists after page refresh
    Given I am on the search result page
    When I select "Title" from the "sort_by" dropdown
    And I refresh the page
    Then the "sort_by" dropdown should be "Title"
    And the search results should be sorted by game title in ascending order