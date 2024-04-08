Feature: Displaying games with dimensions

  Scenario: Viewing all games with 3D contents
    Given I am on the games with 3D contents page
    Then I should see the heading "All Games with 3D Contents"
    And I should see a link to return to main page
    And I should see a list of games with 3D contents
    And I should see a list of games with 2D contents
    And I should see a list of games needing further information
