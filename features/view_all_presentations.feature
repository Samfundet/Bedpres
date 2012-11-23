@dev
Feature: View presentations
  In order to administer presentations
  As a presentation administrator
  I want to view all of them

  Background:
    Given there are upcoming presentations titled Statoildagen, iOS med Bekk
    And there are past presentations titled Testing med Visma
    And I am logged in as an administrator

  Scenario: List all presentations
    Given I am on the home page
    Then I should see a presentation named "Statoildagen"
    And I should see a presentation named "iOS med Bekk"
    And I should see a presentation named "Testing med Visma"

  Scenario: View information about a particular presentation
    Given I am on the presentation page for "Statoildagen"
    Then I should see information about "Statoildagen"
