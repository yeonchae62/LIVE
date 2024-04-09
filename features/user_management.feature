# features/user_management.feature

Feature: User Management
  Scenario: View users 
    Given there are existing users
    When I visit the user management page
    Then I should see a list of all users

#  Scenario: Changing user role
#    Given there are existing users
#    When I visit the user management page
#    When I change the role of a user to admin
#    Then I should see user role as admin

  Scenario: Admin changes a user's role
    Given I am logged in as an admin
    And there is a user with the email "user@example.com" and role "user"
    When I visit the user management page
    And I change the role of "user@example.com" to "Moderator"
    And I should see a notice "User role updated successfully."
    And the user "user@example.com" should have the role "moderator"
