# features/user_management.feature

Feature: User Management
  Scenario: View users 
    Given there are existing users
    When I visit the user management page
    Then I should see a list of all users

  Scenario: Changing user role
    Given there are existing users
    When I visit the user management page
    When I change the role of a user
    Then I should see a success message
    And the user's role should be updated

