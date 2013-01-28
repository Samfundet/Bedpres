Feature: Manage presentations
  In order to have people participating on presentations
  As a presentation administrator
  I want to manage the presentations

  Background:
    Given I am logged in as an administrator

  Scenario: Create presentation
    Given there is an area named "Storsalen"
    And there is not any presentations named "Statoildagen"
    And I am on the home page
    When I follow "Opprett presentasjon"
    And I fill in the following:
      | Navn             | Statoildagen                    |
      | Bedrift          | Statoil                         |
      | Beskrivelse      | Dette blir en kul presentasjon. |
      | Plassbegrensning | 200                             |
    And I select "Storsalen" from "Lokale"
    And I press "Opprett presentasjon"
    Then I should be on the home page
    And I should see a presentation named "Statoildagen"

  Scenario: Edit presentation
    Given there is an upcoming presentation titled Statoildagen
    And I am on the presentation page for "Statoildagen"
    When I follow "Rediger"
    And I fill in the following:
      | Navn             | Vismadagen                      |
    And I press "Oppdater presentasjon"
    Then I should be on the home page
    And I should not see a presentation named "Statoildagen"
    And I should see a presentation named "Vismadagen"

  Scenario: Delete presentation
    Given there is an upcoming presentation titled Statoildagen
    And I am on the presentation page for "Statoildagen"
    When I follow "Slett"
    Then I should be on the home page
    And I should not see a presentation named "Statoildagen"

  Scenario: Cancel presentation
    Given there is an upcoming presentation titled Statoildagen
    And I am on the presentation page for "Statoildagen"
    When I follow "Avlys"
    Then I should be on the presentation page for "Statoildagen"
    And I should see a canceled presentation named "Statoildagen"
