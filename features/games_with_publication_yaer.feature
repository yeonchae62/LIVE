Feature: Displaying games with publication year

  Scenario: Viewing all games with publication year
    Given I am on the games with publication-year page
    Then I should see a link to return to the main page from games with publication year
    Then I should see a list of latest games
    Then I should see a list of game needed to be checked
    Then I should see a list of latest game needed to further updates

