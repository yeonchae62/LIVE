Feature: Main Page
  As a general user
  So that I may navigate the application
  I want to visit the main page and see relevant information and links

  Scenario: User visits the main page
    When I visit the main page
    Then I should see "Live Lab"
    And I should see "Welcome to Our Website"
    And I should see a link "Log In" leading to the login page
    And I should see "This is a project of educational video games for LIVE Lab"
    And I should see a search input field with placeholder "Search..."
    And I should see a search button
    And I should see six image containers
    And I should see a link "View All Games" leading to the games page
