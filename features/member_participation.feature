Feature: Participation
  In order to have attendance at presentations
  As a registered member
  I want to register my attendance

  Background:
    Given there is a member with firstname "Jane", surname "Doe", email "jane.doe@gmail.com" and password "password"
    And I am logged in as an member with email "jane.doe@gmail.com" and password "password"
    And there is a upcoming presentation titled Statoildagen

  Scenario: Attend presentation
    Given I am on the presentation page for "Statoildagen"
    When I follow "Meld meg på"
    Then I should see a message explaining the success
    And a user named "Jane Doe" should be on the attendance list for "Statoildagen"

  Scenario: Cancel attendance
    Given a member named "Jane Doe" is on the attendance list for "Statoildagen"
    And I am on the presentation page for "Statoildagen"
    When I follow "Meld meg av!"
    Then I should see a message explaining the success
    And a user named "Jane Doe" should not be on the attendance list for "Statoildagen"

  Scenario: Cancel attendance for past presentation
    Given there is a past presentation titled Vismadagen
    And a member named "Jane Doe" is on the attendance list for "Vismadagen"
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg av!"
    Then I should see a message explaining the error
    And a user named "Jane Doe" should be on the attendance list for "Vismadagen"

  Scenario: Cancel attendance for canceled presentation
    Given there is a canceled presentation titled Vismadagen
    And a member named "Jane Doe" is on the attendance list for "Vismadagen"
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg av!"
    Then I should see a message explaining the error
    And a user named "Jane Doe" should be on the attendance list for "Vismadagen"

  Scenario: Attending past presentation
    Given there is a past presentation titled Vismadagen
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg på"
    Then I should see a message explaining the error
    And a member named "Jane Doe" should not be on the attendance list for "Vismadagen"

  Scenario: Attending canceled presentation
    Given there is a canceled presentation titled Vismadagen
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg på"
    Then I should see a message explaining the error
    And a member named "Jane Doe" should not be on the attendance list for "Vismadagen"

  Scenario: Attending full presentation
    Given there is a full presentation titled Vismadagen
    And I am on the presentation page for "Vismadagen"
    When I follow "Meld meg på"
    Then I should see a message explaining the error
    And a member named "Jane Doe" should not be on the attendance list for "Vismadagen"
