Feature: Manage users
  In order for someone to attend presentations
  As a guest/user
  They need to create and keep a profile updated

  Scenario: Registration
    Given I am on the registration page
    When I fill in the following:
      | E-post          | jane.doe@gmail.com               |
      | Fornavn         | Jane                             |
      | Etternavn       | Doe                              |
      | Passord         | passord                          |
      | Bekreft passord | passord                          |
    And I press "Opprett bruker"
    Then I should be on login page
    And I should not be able to log in with "jane.doe@gmail.com"" and "passord"
    And I should see a message explaining the success
    And "jane.doe@gmail.com" should receive an email
    When I open the email
    And I follow "bekrefte" in the email
    Then I should be able to log in with "jane.doe@gmail.com" and "passord"

  Scenario: Edit profile
    Given there is a user with firstname "John", surname "Doe", email "john.doe@gmail.com" and password "password"
    And I am logged in as an user with email "john.doe@gmail.com" and password "password"
    And I am on the home page
    When I follow "John Doe"
    And I fill in the following:
      | Fornavn         | John                             |
    And I press "Oppdater bruker"
    Then I should be on the home page
    And I should see a message explaining the success
    And there should be a user with firstname "John" and surname "Doe"
    And there should not be a user with firstname "Jane" and surname "Doe"
