Feature: Create "My Profile" page with user details and actions

  Background:
    Given I have registered with email "user@example.com" and password "password"

  Scenario: Show a button to log in if not logged in
    Given I am not logged in
    When I go to My Profile page
    Then I should be redirected to the login page

  Scenario: Viewing the "My Profile" page
    Given I am logged in as a user
    When I go to My Profile page
    Then I should see my email is "user@example.com"
    And I should see my role is "user"
    And I should see a link to "Change Password"
    And I should see a link to "Sign Out"

  Scenario: Changing password from the "My Profile" page
    Given I am logged in as a user
    And I am on My Profile page
    When I click on the "Change Password" button
    Then I should be redirected to password change page

  Scenario: Signing out from the "My Profile" page
    Given I am logged in as a user
    And I am on My Profile page
    When I click on the "Sign Out" button
    Then I should see a message saying "Signed out successfully."
    And I should be redirected to home page
    And I should see a link to "Log In"