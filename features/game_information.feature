Feature: Display Game Information Page

  Scenario: View Game Information
    Given I have a game "Game1" with the image_url "http://image.com"
    When I visit the game information page for "Game1"
    Then I should see an image for the game
    And I should see a link to edit the game
    And I should see a link to go back to the games list
