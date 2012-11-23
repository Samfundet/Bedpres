@dev
Feature: View presentations
  In order to attend presentations
  As a registered user
  I want to view them

  Background:
    Given there are upcoming presentations titled Statoildagen, iOS med Bekk
    And there are past presentations titled Testing med Visma
    And I am logged in as an user

  Scenario: List all upcoming presentations
    Given I am on the home page
    Then I should see a presentation named "Statoildagen"
    And I should see a presentation named "iOS med Bekk"
    And I should not see a presentation named "Testing med Visma"

  Scenario: View information about a particular presentation
    Given I am on the presentation page for "Statoildagen"
    Then I should see information about "Statoildagen"
