Feature: Display Game Information Page

  Scenario: View Game Information with Image
    Given I have a game "Game1" with the image_url "http://image.com"
    When I visit the game information page for "Game1"
    Then I should see an image for the game

  Scenario: View Game Information without Image
    Given I have a game "Game2" without an image
    When I visit the game information page for "Game2"
    Then I should not see an image for the game