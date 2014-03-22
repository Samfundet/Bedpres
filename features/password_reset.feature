Feature: Password reset
  In order to ensure continuous use of accounts
  As a registered, not logged in user
  I want to be able to reset my password

  Background:
    Given there is a user with email "john.doe@gmail.com" and password "i have forgotten this"

  Scenario: Successful password reset
    Given I am on the reset password page
    When I fill in the following:
      | E-post          | john.doe@gmail.com               |
    And press "Glemt passordet ditt?"
    Then "john.doe@gmail.com" should receive an email
    When I open the email
    And I follow "tilbakestill" in the email
    When I fill in the following:
      | Passord         | password                         |
      | Bekreft passord | password                         |
    And I press "Tilbakestill passord"
    Then I should be able to log in with "john.doe@gmail.com" and "password"

  Scenario: Unsuccessful password reset
    Given I am on the reset password page
    When I fill in the following:
      | E-post          | john.doe@gmail.com               |
    And press "Glemt passordet ditt?"
    Then "john.doe@gmail.com" should receive an email
    When I open the email
    And I follow "tilbakestill" in the email
    When I fill in the following:
      | Passord         | password                         |
      | Bekreft passord | not the samepassword             |
    And I press "Tilbakestill passord"
    Then I should not be able to log in with "john.doe@gmail.com" and "password"
    And I should see a message explaining the error
