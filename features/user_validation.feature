Feature: User model validation

  Scenario: User is valid with name and email
    Given I have a user with name "Example User" and email "user@example.com"
    When I check if the user is valid
    Then the user should be valid

  Scenario: User is invalid without a name
    Given I have a user with name "" and email "user@example.com"
    When I check if the user is valid
    Then the user should not be valid

  Scenario: User is invalid without an email
    Given I have a user with name "Example User" and email "     "
    When I check if the user is valid
    Then the user should not be valid
