Feature: Not view attendance
  In order maintain personal privacy
  As a regular user
  I want to not be able to view the attendance list

  Background:
    Given there is a upcoming presentation titled Statoildagen
    And there is a user with firstname "Ola" and surname "Nordmann"
    And a user named "Ola Nordmann" is on the attendance list for "Statoildagen"
    And I am logged in as an user

  Scenario: Not view list
    Given I am on the presentation page for "Statoildagen"
    Then I should not see "Ola Nordmann" as attending
