# features/create_user_account.feature

Feature: Create user account
  Scenario: User signs up successfully
    Given I am on the sign up page
    When I write in "Email" with "user@example.com"
    And I write in "Password" with "password123"
    And I write in "Password confirmation" with "password123"
    And I press "Sign up"
    Then I shall see "Welcome to Our Website"

  Scenario: User fails to sign up with invalid information
    Given I am on the sign up page
    When I write in "Email" with "invalid_email"
    And I write in "Password" with "password123"
    And I write in "Password confirmation" with "password456"
    And I press "Sign up"
    Then I shall see "Password confirmation doesn't match Password"

  Scenario: Registering as a user - default role
    Given I am on the registration page
    When I fill in the registration form with valid data
    And I submit the registration form
    Then I should see a successful registration message
    And the user should have the default role