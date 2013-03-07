Feature: View attendance
  In order to give the right people access to a presentation
  As a presentation administrator
  I want to view the attendance list

  Background:
    Given there is a upcoming presentation titled Statoildagen
    And there is a user with firstname "Ola" and surname "Nordmann"
    And a user named "Ola Nordmann" is on the attendance list for "Statoildagen"
    And I am logged in as an administrator

  Scenario: View list
    Given I am on the presentation page for "Statoildagen"
    Then I should see "Ola Nordmann" as attending
