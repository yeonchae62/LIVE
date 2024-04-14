Feature: Displaying games with dimensions

  Scenario: Viewing all games with 3D contents
    Given I am on the games with dimensions page
    Then I should see a link to return to the main page from games with dimensions
    Then I should see a list of 3D games
    Then I should see a list of 2D games
    Then I should see a list of games needing further updates on the games with dimensions page

