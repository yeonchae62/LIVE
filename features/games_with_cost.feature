Feature: Displaying games with cost

  Scenario: Viewing all games with cost
    Given I am on the games with cost page
    Then I should see a link to return to the main page from games with cost
    Then I should see a list of free games
    Then I should see a list of games with cost information on the games
    Then I should see a list of games needing further updates on the games with cost page
