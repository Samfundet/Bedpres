Feature: Authentication
  In order to utilize the access controlled features of the application
  As a registered member
  I want to log in

  Background:
    Given there is a member with email "valid@member.com" and password "password"

  Scenario: Go to the login page
    Given I am on the home page
    When I follow "Logg inn"
    Then I should be on the login page

  Scenario: Direct successful login
    Given I am on the login page
    When I fill in "valid@member.com" for "member_mail"
    And I fill in "password" for "member_passord"
    And I press "member_login"
    Then I should be on the home page
    And I should be logged in

  Scenario: Direct unsuccessful login
    Given I am on the login page
    When I fill in "invalid@member.com" for "member_mail"
    And I fill in "invalid password" for "member_passord"
    And I press "member_login"
    Then I should be on login page
    And I should not be logged in
    And the "member_mail" field should contain "invalid@member.com"
    And I should see a message explaining the error
