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


  Scenario: Displaying links
    Given I am on the homepage
    Then I should see a link to view games by cost
    And I should see a link to view latest game
    And I should see a link to view 3D games

  Scenario: Navigation bar on the Homepage
    Given I am on the homepage
    Then I should see a navigation bar
    And I should see links to "HOME", "GAMES", "MY PROFILE"

  Scenario: Navigation bar on the Game List page
    Given I am on the game list page
    Then I should see a navigation bar
    And I should see links to "HOME", "GAMES", "MY PROFILE"

  Scenario: Navigation bar on the My Profile page
    Given I am on My Profile page
    Then I should see a navigation bar
    And I should see links to "HOME", "GAMES", "MY PROFILE"

  Scenario: Navigating from one page to another using the navigation bar
    Given I am on the homepage
    And I have registered with email "user@example.com" and password "password"
    And I am logged in as a user
    When I click on the "GAMES" link in the navigation bar
    Then I should be redirected to game list page
    When I click on the "MY PROFILE" link in the navigation bar
    Then I should be on My Profile page
    When I click on the "HOME" link in the navigation bar
    Then I should be redirected to home page
