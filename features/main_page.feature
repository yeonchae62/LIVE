Feature: Main Page Content and Navigation

#  Scenario: Viewing the main page content
#    When I visit the main page
#    Then I should see "Live Lab"
#    And I should see "Welcome to Our Website"
#    And I should see "This is a project of educational video games for LIVE Lab"

  Scenario: Main page search functionality presence
    When I visit the main page
    Then I should see a search input field with placeholder "Search..."
    And I should see a search button

  Scenario: Main page game container visibility
    Given I have the most_watched games
    When I visit the main page
    Then I should see six image containers

  Scenario: Navigating to the login page
    When I visit the main page
    Then I should see a link "Log In" leading to the login page

#  Scenario: Navigating to the games page
#    When I visit the main page
#    Then I should see a link "View All Games" leading to the games page

  Scenario: Visitor clicks on a game title link
    Given I have the most_watched games
    And I visit the main page
    When I click on the title of the first game
    Then I should be redirected to the game details page
