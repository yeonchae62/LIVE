Feature: Displaying games with cost

  Scenario: Viewing all games with cost
    Given I am on the games with cost page
    Then I should see the heading "All Games with Cost"
    And I should see a link to return to main page
    And I should see a list of free games
    And I should see a list of games with cost information
    And I should see a list of games needing further updates
