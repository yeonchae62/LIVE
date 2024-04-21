Feature: Game management
  As a user
  I want to manage games

  Background:
    Given I have a game titled "Game1" with the url "http://game1.com" and source "New Source"
    And I have a game titled "Lost Recipes" with the url "https://www.meta.com/experiences/4584847304916084/?utm_source=schellgames.com&utm_medium=oculusredirect" and source "Schell Games"
    And I am an admin

  Scenario: Creating a new game - signed in user
    Given I am on the game list page
    When I click "New Game"
    And I fill in "Game Title" with "New Game"
    And I fill in "URL" with "http://newgame.com"
    And I click "Create Game" button
    Then I should be on the "New Game" details page
  
  Scenario: Creating a new game - unsigned in user
    Given I am on the game list page
    And I signed out
    Then I should not see "New Game" button
    And I attempt to access new game page
    Then I should be shown a forbidden error

  Scenario: Unsuccessful creation of a game
    Given I am on the new game page
    When I fill in "Game Title" with ""
    And I click "Create Game" button
    Then I should see "can't be blank"

  Scenario: Viewing games
    Given I am on the game list page
    And I should see a "Return to main" button
    When I click the game titled "Lost Recipes"
    Then I should be on the "Lost Recipes" details page
    And I should see "Schell Games" on the page

  Scenario: Updating a game
    Given I am on the "Game1" details page
    When I click "Edit this game"
    And I fill in "Game Title" with "Game1 Updated"
    And I click "Update Game" button
    Then I should be on the "Game1 Updated" details page

  Scenario: Unsuccessful game update due to invalid input
    Given I am on the "Game1" edit page
    When I fill in "Game Title" with ""
    And I click "Update Game" button
    Then I should see "can't be blank"

  Scenario: Deleting a game
    Given I am on the "Game1" details page
    When I click "Destroy this game" button
    Then I should be redirected to game list page
    And I should not see "Game1" in the game list

  Scenario: Go back to home page
    Given I am on the game list page
    When I click "Return to main" button
    Then I should be redirected to home page

  Scenario: Hide destroy button for moderator
    Given I changed my role to "moderator"
    And I am on the "Game1" details page
    Then I should not see "Destroy" button

  Scenario: Hide destroy and edit button for user 
    Given I changed my role to "user"
    And I am on the "Game1" details page
    Then I should not see "Destroy" button
    And I should not see "Edit this game" button

  Scenario: Non-admin user attempts to edit a game
    Given I changed my role to "user"
    And there is a game with id "11"
    When I attempt to access the edit page for game "11"
    Then I should be shown a forbidden error

  Scenario: Non-logged-in user attempts to update a game
    Given there is a game with id "22"
    And I changed my role to "user"
    When I attempt to update the game with id "22"
    Then I should be shown a forbidden error

  Scenario: Regular user attempts to delete a game
    Given I changed my role to "user"
    And there is a game with id "3"
    When I attempt to delete the game with id "3"
    Then I should be shown a forbidden error
    And I should not be shown a "Update" content
  
  Scenario: Regular user attempts to delete a game
    Given I changed my role to "user"
    When I attempt to create the game with id "101"
    Then I should be shown a forbidden error
    And I should not be shown a "Update" content
