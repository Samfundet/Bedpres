Feature: Authentication
  In order to utilize the access controlled features of the application
  As a registered user
  I want to log in

  Background:
    Given there is a user with email "valid@user.com" and password "password"

  Scenario: Go to the login page
    Given I am on the home page
    When I follow "Logg inn"
    Then I should be on the login page

  Scenario: Direct successful login
    Given I am on the login page
    When I fill in "valid@user.com" for "user_email"
    And I fill in "password" for "user_password"
    And I press "user_login"
    Then I should be on the home page
    And I should be logged in

  Scenario: Direct unsuccessful login
    Given I am on the login page
    When I fill in "invalid@user.com" for "user_email"
    And I fill in "invalid password" for "user_password"
    And I press "user_login"
    Then I should be on login page
    And I should not be logged in
    And the "user_email" field should contain "invalid@user.com"
