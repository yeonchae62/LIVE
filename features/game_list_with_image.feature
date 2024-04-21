Feature: Display Game List with Image

  Scenario: View Game List with Image
    Given there are games with images
    When I visit the games list page
    Then I should see game information with images

  Scenario: View Game List without Image
    Given there are games without images
    When I visit the games list page
    Then I should see game information with default images
